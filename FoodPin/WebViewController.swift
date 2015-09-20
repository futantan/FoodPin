//
//  WebViewController.swift
//  FoodPin
//
//  Created by luckytantanfu on 9/20/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
  
  @IBOutlet weak var webView: UIWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    if let url = NSURL(string: "http://www.appcoda.com") {
      let request = NSURLRequest(URL: url)
      webView.loadRequest(request)
    }
  }
}
