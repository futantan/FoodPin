//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by luckytantanfu on 9/17/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var dialogView: UIView!
  
  override func viewDidLoad() {
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    backgroundImageView.addSubview(blurEffectView)
    
    let scale = CGAffineTransformMakeScale(0.0, 0.0)
    let translate = CGAffineTransformMakeTranslation(0, 500)
    dialogView.transform = CGAffineTransformConcat(scale, translate)
  }
  
  override func viewDidAppear(animated: Bool) {
    UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: nil, animations: {
      let scale = CGAffineTransformMakeScale(1, 1)
      let translate = CGAffineTransformMakeTranslation(0, 0)
      self.dialogView.transform = CGAffineTransformConcat(scale, translate)
    }, completion: nil)
  }
}
