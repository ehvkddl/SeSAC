//
//  OnboardingViewController.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/26.
//

import UIKit

class OnboardingViewController: UIPageViewController {

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

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return introViewList.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = introViewList.firstIndex(of: first) else { return 0 }

        return index
    }
    
}
