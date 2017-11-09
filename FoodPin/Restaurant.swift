//
//  Restaurant.swift
//  FoodPin
//
//  Created by Yimeng Zhou on 7/3/15.
//  Copyright (c) 2015 Yimeng Zhou. All rights reserved.
//

import Foundation
import CoreData

class Restaurant:NSManagedObject {
    
    @NSManaged var name:String!
    @NSManaged var type:String!
    @NSManaged var location:String!
    @NSManaged var image:NSData!
    @NSManaged var isVisited:NSNumber!
    /*var name:String = ""
    var type:String = ""
    var location:String = ""
    var image:String = ""
    var isVisited:Bool = false*/
    /*init(name:String, type:String, location:String, image:String, isVisited:Bool) {
    self.name = name
    self.type = type
    self.location = location
    self.image = image
    self.isVisited = isVisited*/
   // }
}
