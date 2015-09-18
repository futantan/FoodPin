//
//  DetailViewController.swift
//  FoodPin
//
//  Created by luckytantanfu on 9/15/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var restaurantImageView: UIImageView!
  @IBOutlet weak var tableView: UITableView!
  
  var restaurant: Restaurant!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    
    self.navigationController?.hidesBarsOnSwipe = false
    self.navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.restaurantImageView.image = UIImage(named: restaurant.image)
    self.tableView.backgroundColor = UIColor(red: 240.0 / 255.0, green: 240.0 / 255.0, blue: 240.0 / 255.0, alpha: 0.2) // 设置背景颜色
    self.tableView.tableFooterView = UIView(frame: CGRectZero) // 去除空白行的分隔线
    self.tableView.separatorColor = UIColor(red: 240.0 / 255.0, green: 240.0 / 255.0, blue: 240.0 / 255.0, alpha: 0.8) // 设置分割线颜色
    self.title = self.restaurant.name
    
    tableView.estimatedRowHeight = 36.0
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  @IBAction func close(segue: UIStoryboardSegue) {
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showMap" {
      let destinationController = segue.destinationViewController as! MapViewController
      destinationController.restaurant = self.restaurant
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DetailTableViewCell
    cell.backgroundColor = UIColor.clearColor() // 让背景透明，才能显示出背景颜色
    cell.mapButton.hidden = true
    
    switch indexPath.row {
    case 0:
      cell.fieldLabel.text = "Name"
      cell.valueLabel.text = restaurant.name
    case 1:
      cell.fieldLabel.text = "Type"
      cell.valueLabel.text = restaurant.type
    case 2:
      cell.fieldLabel.text = "Location"
      cell.valueLabel.text = restaurant.location
      cell.mapButton.hidden = false
    case 3:
      cell.fieldLabel.text = "Been here"
      cell.valueLabel.text = (restaurant.isVisited) ? "Yes, I've been here before" : "No"
    default:
      cell.fieldLabel.text = ""
      cell.valueLabel.text = ""
    }
    
    return cell
  }
  
}
