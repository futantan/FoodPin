//
//  PageViewController.swift
//  FoodPin
//
//  Created by luckytantanfu on 9/19/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

  var pageHeadings = ["Personalize", "Locate", "Discover"]
  var pageImages = ["homei", "mapintro", "fiveleaves"]
  var pageSubHeadings = [
      "Pin your favourite restaurants and create your own food guide",
      "Search and locate your favourite restaurant on Maps",
      "Find restaurants pinned by your friends and other foodies around the world"
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    dataSource = self
    
    if let startingViewController = self.viewControllerAtIndex(0) {
      setViewControllers([startingViewController], direction: .Forward, animated: true, completion: nil)
    }
  }
  
  func viewControllerAtIndex(index: Int) -> PageContentViewController? {
    if index == NSNotFound || index < 0 || index >= self.pageHeadings.count {
      return nil
    }
    
    if let pageContentViewController = storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as? PageContentViewController {
      pageContentViewController.imageFile = pageImages[index]
      pageContentViewController.heading = pageHeadings[index]
      pageContentViewController.subHeading = pageSubHeadings[index]
      pageContentViewController.index = index
      
      return pageContentViewController
    }
    
    return nil
  }
  
  func forward(index: Int) {
    if let nextViewController = self.viewControllerAtIndex(index + 1) {
      setViewControllers([nextViewController], direction: .Forward, animated: true, completion: nil)
    }
  }

}

extension PageViewController: UIPageViewControllerDataSource {
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    var index = (viewController as! PageContentViewController).index
    index++
    
    return self.viewControllerAtIndex(index)
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    var index = (viewController as! PageContentViewController).index
    index--
    
    return self.viewControllerAtIndex(index)
  }
}
