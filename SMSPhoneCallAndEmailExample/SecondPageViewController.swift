//
//  SecondPageViewController.swift
//  SMSPhoneCallAndEmailExample
//
//  Created by Anmol singh on 2020-03-25.
//  Copyright © 2020 moxDroid. All rights reserved.
//

import UIKit

class SecondPageViewController: UIPageViewController {

    private(set) lazy var orderedViewControllers: [UIViewController] = {
            return [self.getNewViewController(name: "firstInstructionVC"),
                    self.getNewViewController(name: "secondInstructionVC"),
                    self.getNewViewController(name: "thirdInstructionVC")]
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()

            dataSource = self
            
            //Load first view contoller in Pager
            if let firstViewController = orderedViewControllers.first {
                setViewControllers([firstViewController],
                                   direction: .forward,
                                   animated: true,
                                   completion: nil)
            }
        }
        
        private func getNewViewController(name: String) -> UIViewController {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            return storyBoard.instantiateViewController(withIdentifier: name)
        }
    }

    extension SecondPageViewController: UIPageViewControllerDataSource {
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
                return nil
            }
            
            let previousIndex = viewControllerIndex - 1
            
            // User is on the first view controller and swiped left to loop to
            // the last view controller.
            guard previousIndex >= 0 else {
                return orderedViewControllers.last
            }
            
            guard orderedViewControllers.count > previousIndex else {
                return nil
            }
            
            return orderedViewControllers[previousIndex]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
                return nil
            }
            
            let nextIndex = viewControllerIndex + 1
            let orderedViewControllersCount = orderedViewControllers.count
            
            // User is on the last view controller and swiped right to loop to
            // the first view controller.
            guard orderedViewControllersCount != nextIndex else {
                return orderedViewControllers.first
            }
            
            guard orderedViewControllersCount > nextIndex else {
                return nil
            }
            
            return orderedViewControllers[nextIndex]
        }
        

    }
     
