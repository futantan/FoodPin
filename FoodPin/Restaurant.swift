//
//  Restaurant.swift
//  FoodPin
//
//  Created by luckytantanfu on 9/16/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import Foundation

class Restaurant {
  var name: String = ""
  var type: String = ""
  var location: String = ""
  var image: String = ""
  var isVisited: Bool = false
  
  init(name: String, type: String, location: String, imageName: String, isVisited: Bool) {
    self.name = name
    self.type = type
    self.location = location
    self.image = imageName
    self.isVisited = isVisited
  }
}