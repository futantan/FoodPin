//
//  AddTableViewController.swift
//  FoodPin
//
//  Created by luckytantanfu on 9/18/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit
import CoreData

class AddTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var typeTextField: UITextField!
  @IBOutlet weak var locationTextField: UITextField!
  @IBOutlet weak var yesButton: UIButton!
  @IBOutlet weak var noButton: UIButton!
  var isVisited = true

  var restaurant: Restaurant!


  @IBAction func save(sender: AnyObject) {
    // Form validation
    var errorField = ""

    if nameTextField.text == "" {
      errorField = "name"
    } else if locationTextField.text == "" {
      errorField = "location"
    } else if typeTextField.text == "" {
      errorField = "type"
    }

    if errorField != "" {
      let alertController = UIAlertController(title: "Oops", message: "We can't proceed as you forget to fill in the restaurant " + errorField + ". All fields are mandatory.", preferredStyle: .Alert)
      let doneAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
      alertController.addAction(doneAction)

      self.presentViewController(alertController, animated: true, completion: nil)

      return
    }

    // If all fields are correctly filled in, extract the field value
    println("Name: " + nameTextField.text)
    println("Type: " + typeTextField.text)
    println("Location: " + locationTextField.text)
    println("Have you been here: " + (isVisited ? "yes" : "no"))
    
    if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
      restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: managedObjectContext) as! Restaurant
      restaurant.name = nameTextField.text
      restaurant.type = typeTextField.text
      restaurant.location = locationTextField.text
      restaurant.image = UIImagePNGRepresentation(imageView.image)
      restaurant.isVisited = isVisited
      
      var error: NSError?
      if managedObjectContext.save(&error) != true {
        println("insert error: \(error!.localizedDescription)")
        return
      }
    }

    // Execute the unwind segue and go back to the home screen
    performSegueWithIdentifier("unwindToHomeScreen", sender: self)
  }

  @IBAction func updateIsVisited(sender: AnyObject) {
    // Yes button clicked
    let buttonClicked = sender as! UIButton
    if buttonClicked == yesButton {
      isVisited = true
      yesButton.backgroundColor = UIColor(red: 235.0 / 255.0, green: 73.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)
      noButton.backgroundColor = UIColor.grayColor()
    } else if buttonClicked == noButton {
      isVisited = false
      yesButton.backgroundColor = UIColor.grayColor()
      noButton.backgroundColor = UIColor(red: 235.0 / 255.0, green: 73.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)
    }
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.row == 0 {
      if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary

        self.presentViewController(imagePicker, animated: true, completion: nil)
      }
    }

    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }

  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject:AnyObject]) {
    imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    imageView.contentMode = .ScaleAspectFill
    imageView.clipsToBounds = true

    dismissViewControllerAnimated(true, completion: nil)
  }

  func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
    UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
  }
}
