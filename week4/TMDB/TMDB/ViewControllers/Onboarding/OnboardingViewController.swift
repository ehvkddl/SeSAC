//
//  OnboardingViewController.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/26.
//

import UIKit
import SnapKit

class OnboardingViewController: UIPageViewController {
    
    lazy var pageControl = {
        let control = UIPageControl()
        
        control.currentPageIndicatorTintColor = .black
        control.pageIndicatorTintColor = .systemGray2
        control.numberOfPages = introViewList.count
        control.currentPage = 0
        
        return control
    }()
    
    let gotoTrendButton = {
        let btn = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.title = "트렌드 보러가기"
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            
            return outgoing
        }
        
        config.baseForegroundColor = UIColor(red: 216/255, green: 217/255, blue: 218/255, alpha: 1)
        config.baseBackgroundColor = UIColor(red: 39/255, green: 40/255, blue: 41/255, alpha: 1)
        
        config.titleAlignment = .center
        
        config.cornerStyle = .capsule
        config.buttonSize = .large
        
        btn.configuration = config
        
        return btn
    }()

    var introViewList = [UIViewController]()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePage()
        setConstraints()
    }
    
    @objc
    func gotoTrendButtonClicked() {
        UserDefaults.standard.set(true, forKey: "isLaunched")
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: TrendViewController.identifier) as? TrendViewController else { return }
        
        let nav = UINavigationController(rootViewController: vc)
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
}

extension OnboardingViewController {
    
    func configurePage() {
        delegate = self
        dataSource = self
        
        Intro.list.forEach {
            introViewList.append(OnboardingContentViewController(animationName: $0.animationName,
                                                                 titleText: $0.title,
                                                                 subtitleText: $0.subTitle))
        }
        
        guard let first = introViewList.first else { return }
        
        setViewControllers([first], direction: .forward, animated: true)
    }
    
    func setConstraints() {
        [pageControl, gotoTrendButton].forEach{ view.addSubview($0) }
        
        showControl()

        
        gotoTrendButton.addTarget(self, action: #selector(gotoTrendButtonClicked), for: .touchUpInside)
        hideButton()
    }
    
}

extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = introViewList.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = currentIndex - 1
        
        return previousIndex < 0 ? nil : introViewList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = introViewList.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        
        return nextIndex >= introViewList.count ? nil : introViewList[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = introViewList.firstIndex(of: viewControllers[0]) else { return }

        pageControl.currentPage = currentIndex
        animatedControlsAndButtonIfNeeded()
    }
    
    func animatedControlsAndButtonIfNeeded() {
        let isLastPage = pageControl.currentPage == introViewList.count - 1

        if isLastPage {
            hideControl()
            showButton()
        } else {
            showControl()
            hideButton()
        }

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    func hideControl() {
        pageControl.snp.remakeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp.bottom)
        }
    }

    func showControl() {
        pageControl.snp.remakeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func hideButton() {
        gotoTrendButton.snp.remakeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp.bottom)
        }
    }

    func showButton() {
        gotoTrendButton.snp.remakeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(60)
        }
    }
    
}
