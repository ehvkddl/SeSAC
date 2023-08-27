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
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
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
    }
    
}
