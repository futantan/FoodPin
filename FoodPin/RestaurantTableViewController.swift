//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by luckytantanfu on 9/14/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

  var restaurants: [Restaurant] = []
  var searchResults: [Restaurant] = []
  var fetchResultController: NSFetchedResultsController!
  var searchController: UISearchController!

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    self.navigationController?.hidesBarsOnSwipe = true
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let hasViewedWalkthrough = defaults.boolForKey("hasViewedWalkthrough")
    
    if hasViewedWalkthrough == false {
      if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? PageViewController {
        self.presentViewController(pageViewController, animated: true, completion: nil)
      }
    }

    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

    tableView.estimatedRowHeight = 80.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
    searchController = UISearchController(searchResultsController: nil)
    searchController.searchBar.sizeToFit()
    self.tableView.tableHeaderView = searchController.searchBar
    self.definesPresentationContext = true
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    
    var fetchRequest = NSFetchRequest(entityName: "Restaurant")
    let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    
    if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
      fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
      fetchResultController.delegate = self
      
      var error: NSError?
      var result = fetchResultController.performFetch(&error)
      restaurants = fetchResultController.fetchedObjects as! [Restaurant]
      
      if result != true {
        println(error?.localizedDescription)
      }
    }
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showRestaurantDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow() {
        let destinationController = segue.destinationViewController as! DetailViewController
        destinationController.restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
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
    if self.searchController.active {
      return self.searchResults.count
    } else {
      return self.restaurants.count
    }
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "Cell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomTableViewCell

    // Configure the cell...
    let restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
    cell.nameLabel?.text = restaurant.name
    cell.locationLabel?.text = restaurant.location
    cell.typeLabel?.text = restaurant.type
    cell.thumbnailImageView?.image = UIImage(data: restaurant.image)
    cell.favorIconImageView?.hidden = !restaurant.isVisited.boolValue

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

  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    if searchController.active {
      return false
    } else {
      return true
    }
  }
  
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
//      self.restaurants.removeAtIndex(indexPath.row)
//      self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
      if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
        let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as! Restaurant
        managedObjectContext.deleteObject(restaurantToDelete)
        
        var error: NSError?
        if managedObjectContext.save(&error) != true {
          println("delete error: \(error!.localizedDescription)")
        }
      }
    }
    shareAction.backgroundColor = UIColor(red: 255.0 / 255.0, green: 166.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    deleteAction.backgroundColor = UIColor(red: 51.0 / 255.0, green: 51.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    return [deleteAction, shareAction]
  }
  
  func controllerWillChangeContent(controller: NSFetchedResultsController) {
    self.tableView.beginUpdates()
  }
  
  func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
    switch type {
    case .Insert:
      if let _newIndexPath = newIndexPath {
        tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
      }
    case .Delete:
      if let _indexPath = indexPath {
        tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
      }
    case .Update:
      if let _indexPath = indexPath {
        tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
      }
    default:
      tableView.reloadData()
    }
    
    restaurants = controller.fetchedObjects as! [Restaurant]
  }
  
  func controllerDidChangeContent(controller: NSFetchedResultsController) {
    tableView.endUpdates()
  }
  
  func filterContentForSearchText(searchText: String) {
    searchResults = restaurants.filter({ (restaurant: Restaurant) -> Bool in
      let nameMatch = restaurant.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
      let locationMatch = restaurant.location.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
      
      return (nameMatch != nil) || (locationMatch != nil)
    })
  }
}

extension RestaurantTableViewController: UISearchResultsUpdating {
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    let searchText = searchController.searchBar.text
    filterContentForSearchText(searchText)
    tableView.reloadData()
  }
}
