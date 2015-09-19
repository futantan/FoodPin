//
//  PageContentViewController.swift
//  FoodPin
//
//  Created by luckytantanfu on 9/18/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

  @IBOutlet weak var headingLabel: UILabel!
  @IBOutlet weak var subHeadingLabel: UILabel!
  @IBOutlet weak var contentImageView: UIImageView!
  @IBOutlet weak var pageControl: UIPageControl!

  @IBOutlet weak var getStartedButton: UIButton!
  @IBOutlet weak var forwardButton: UIButton!
  
  
  var index: Int = 0
  var heading: String = ""
  var imageFile: String = ""
  var subHeading: String = ""

  override func viewDidLoad() {
    super.viewDidLoad()

    headingLabel.text = heading
    subHeadingLabel.text = subHeading
    contentImageView.image = UIImage(named: imageFile)
    
    pageControl.currentPage = index
    
    getStartedButton.hidden = (index == 2) ? false : true
    forwardButton.hidden = !getStartedButton.hidden
  }
  
  @IBAction func close(sender: AnyObject) {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setBool(true, forKey: "hasViewedWalkthrough")
    
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func nextScreen(sender: AnyObject) {
    let pageViewController = self.parentViewController as! PageViewController
    pageViewController.forward(index)
  }

}
