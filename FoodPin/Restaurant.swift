//
//  Restaurant.swift
//  FoodPin
//
//  Created by luckytantanfu on 9/16/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import Foundation
import CoreData

class Restaurant: NSManagedObject {
  @NSManaged var name: String!
  @NSManaged var type: String!
  @NSManaged var location: String!
  @NSManaged var image: NSData!
  @NSManaged var isVisited: NSNumber!
  
//  init(name: String, type: String, location: String, imageName: String, isVisited: Bool) {
//    self.name = name
//    self.type = type
//    self.location = location
//    self.image = imageName
//    self.isVisited = isVisited
//  }
}