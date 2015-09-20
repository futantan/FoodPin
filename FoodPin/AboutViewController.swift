//
//  AboutViewController.swift
//  FoodPin
//
//  Created by luckytantanfu on 9/20/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController {
  
  @IBAction func sendEmail(sender: AnyObject) {
    if MFMailComposeViewController.canSendMail() {
      var composer = MFMailComposeViewController()
      
      composer.mailComposeDelegate = self
      composer.setToRecipients(["luckytantanfu@icloud.com"])
      composer.navigationBar.tintColor = UIColor.whiteColor()
      
      presentViewController(composer, animated: true, completion: {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
      })
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
}

extension AboutViewController: MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
  func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
    switch result.value {
    case MFMailComposeResultCancelled.value:
      println("Mail cancelled")
      
    case MFMailComposeResultSaved.value:
      println("Mail saved")
      
    case MFMailComposeResultSent.value:
      println("Mail sent")
      
    case MFMailComposeResultFailed.value:
      println("Failed to send mail: \(error.localizedDescription)")
      
    default:
      break
    }
    dismissViewControllerAnimated(true, completion: nil)
  }
}
