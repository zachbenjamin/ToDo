//
//  Item.swift
//  ToDo
//
//  Created by Zach Benjamin on 4/3/18.
//  Copyright © 2018 Zach Benjamin. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var isDone : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
