//
//  ShareViewController.swift
//  FoodPin
//
//  Created by luckytantanfu on 9/17/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
  @IBOutlet weak var backgroundImageView: UIImageView!

  @IBOutlet weak var facebookButton: UIButton!
  @IBOutlet weak var twitterButton: UIButton!
  @IBOutlet weak var messageButton: UIButton!
  @IBOutlet weak var emailButton: UIButton!
  
  override func viewDidLoad() {
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    backgroundImageView.addSubview(blurEffectView)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    
    let translateDown = CGAffineTransformMakeTranslation(0, 500)
    facebookButton.transform = translateDown
    messageButton.transform = translateDown
    
    let translateUp = CGAffineTransformMakeTranslation(0, -500)
    emailButton.transform = translateUp
    twitterButton.transform = translateUp
  }
  
  override func viewDidAppear(animated: Bool) {
    let translate = CGAffineTransformMakeTranslation(0, 0)
    facebookButton.hidden = false
    twitterButton.hidden = false
    emailButton.hidden = false
    messageButton.hidden = false
    
    UIView.animateWithDuration(0.8, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: {
      self.facebookButton.transform = translate
      self.emailButton.transform = translate
      }, completion: nil)
    
    UIView.animateWithDuration(0.8, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: {
      self.twitterButton.transform = translate
      self.messageButton.transform = translate
      }, completion: nil)
  }
}
