//
//  Item.swift
//  VisitorsTracker
//
//  Created by Ashish Chauhan on 11/06/24.
//

import Foundation
import SwiftData

@Model
final class Tower {
    @Attribute(.unique) var name: String
    var floors: Int
    var flats: Int
    @Relationship(deleteRule: .cascade, inverse: \Visitor.tower)
    var visitors: [Visitor] = []
    
    init(name: String, floors: Int, flats: Int) {
        self.name = name
        self.floors = floors
        self.flats = flats
    }
}

@Model
final class Visitor {
    var name: String
    var tower: Tower
    var visiting: String
    var timeStamp: Date
    var purpose: String
    
    init(name: String, tower: Tower, visiting: String, purpose: String) {
        self.name = name
        self.tower = tower
        self.visiting = visiting
        self.timeStamp = Date()
        self.purpose = purpose
    }
}
