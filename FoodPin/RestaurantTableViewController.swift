//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by luckytantanfu on 9/14/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

  var restaurants: [Restaurant] = [
      Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", imageName: "cafedeadend.jpg", isVisited: true),
      Restaurant(name: "Homei", type: "Cafe", location: "Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", imageName: "homei.jpg", isVisited: false),
      Restaurant(name: "Teakha", type: "Tea House", location: "Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", imageName: "teakha.jpg", isVisited: false),
      Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", imageName: "cafeloisl.jpg", isVisited: false),
      Restaurant(name: "Petite Oyster", type: "French", location: "24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", imageName: "petiteoyster.jpg", isVisited: false),
      Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Shop J-K., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", imageName: "forkeerestaurant.jpg", isVisited: false),
      Restaurant(name: "Po's Atelier", type: "Bakery", location: "G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", imageName: "posatelier.jpg", isVisited: false),
      Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "633 Bourke St Sydney New South Wales 2010 Surry Hills", imageName: "bourkestreetbakery.jpg", isVisited: false),
      Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "412-414 George St Sydney New South Wales", imageName: "haighschocolate.jpg", isVisited: false),
      Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Shop 1 61 York St Sydney New South Wales", imageName: "palominoespresso.jpg", isVisited: false),
      Restaurant(name: "Upstate", type: "American", location: "95 1st Ave New York, NY 10003", imageName: "upstate.jpg", isVisited: false),
      Restaurant(name: "Traif", type: "American", location: "229 S 4th St Brooklyn, NY 11211", imageName: "traif.jpg", isVisited: false),
      Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "445 Graham Ave Brooklyn, NY 11211", imageName: "grahamavenuemeats.jpg", isVisited: false),
      Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "413 Graham Ave Brooklyn, NY 11211", imageName: "wafflewolf.jpg", isVisited: false),
      Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "18 Bedford Ave Brooklyn, NY 11222", imageName: "fiveleaves.jpg", isVisited: false),
      Restaurant(name: "Cafe Lore", type: "Latin American", location: "Sunset Park 4601 4th Ave Brooklyn, NY 11220", imageName: "cafelore.jpg", isVisited: false),
      Restaurant(name: "Confessional", type: "Spanish", location: "308 E 6th St New York, NY 10003", imageName: "confessional.jpg", isVisited: false),
      Restaurant(name: "Barrafina", type: "Spanish", location: "54 Frith Street London W1D 4SL United Kingdom", imageName: "barrafina.jpg", isVisited: false),
      Restaurant(name: "Donostia", type: "Spanish", location: "10 Seymour Place London W1H 7ND United Kingdom", imageName: "donostia.jpg", isVisited: false),
      Restaurant(name: "Royal Oak", type: "British", location: "2 Regency Street London SW1P 4BZ United Kingdom", imageName: "royaloak.jpg", isVisited: false),
      Restaurant(name: "Thai Cafe", type: "Thai", location: "22 Charlwood Street London SW1V 2DY Pimlico", imageName: "thaicafe.jpg", isVisited: false)
  ]

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    self.navigationController?.hidesBarsOnSwipe = true
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

    tableView.estimatedRowHeight = 80.0
    tableView.rowHeight = UITableViewAutomaticDimension
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showRestaurantDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow() {
        let destinationController = segue.destinationViewController as! DetailViewController
        destinationController.restaurant = restaurants[indexPath.row]
      }
    }
  }

  @IBAction func unwindToHomeScreen(sender: UIStoryboardSegue) {

  }

// MARK: - Table view data source

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // Return the number of sections.
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return the number of rows in the section.
    return self.restaurants.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "Cell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomTableViewCell

    // Configure the cell...
    let restaurant = restaurants[indexPath.row]
    cell.nameLabel?.text = restaurant.name
    cell.locationLabel?.text = restaurant.location
    cell.typeLabel?.text = restaurant.type
    cell.thumbnailImageView?.image = UIImage(named: restaurant.image)
    cell.favorIconImageView?.hidden = !restaurant.isVisited

    cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
    cell.thumbnailImageView.clipsToBounds = true

    return cell
  }

//  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    let optionMenu = UIAlertController(title: nil, message: "what do you want to do?", preferredStyle: .ActionSheet)
//    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//    optionMenu.addAction(cancelAction)
//
//    let callActionHandler = {
//      (action: UIAlertAction!) -> Void in
//      let alertMessage = UIAlertController(title: "Service Unavailable",
//          message: "Sorry, the call feature is not available yet. Please retry later.",
//          preferredStyle: .Alert)
//      alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//      self.presentViewController(alertMessage, animated: true, completion: nil)
//    }
//    let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .Default, handler: callActionHandler)
//    optionMenu.addAction(callAction)
//
//    let restaurant = self.restaurants[indexPath.row]
//    let isVisitedTitle = restaurant.isVisited ? "I haven't been to there before" : "I've been here"
//    let isVisitedAction = UIAlertAction(title: isVisitedTitle, style: .Default, handler: {
//      (action: UIAlertAction!) -> Void in
//
//      let cell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell
//      restaurant.isVisited = !restaurant.isVisited
//      cell.favorIconImageView.hidden = !restaurant.isVisited
//
//    })
//    optionMenu.addAction(isVisitedAction)
//
//    self.presentViewController(optionMenu, animated: true, completion: nil)
//    tableView.deselectRowAtIndexPath(indexPath, animated: false)
//  }

  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//    if editingStyle == .Delete {
//      self.restaurants.removeAtIndex(indexPath.row)
//
//      self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//    }
  }

  override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
    var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share") {
      (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
      let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)
      let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: nil)
      let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.Default, handler: nil)
      let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)

      shareMenu.addAction(twitterAction)
      shareMenu.addAction(facebookAction)
      shareMenu.addAction(cancelAction)

      self.presentViewController(shareMenu, animated: true, completion: nil)
    }

    var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete") {
      (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
      self.restaurants.removeAtIndex(indexPath.row)

      self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    shareAction.backgroundColor = UIColor(red: 255.0 / 255.0, green: 166.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    deleteAction.backgroundColor = UIColor(red: 51.0 / 255.0, green: 51.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    return [deleteAction, shareAction]
  }

}
