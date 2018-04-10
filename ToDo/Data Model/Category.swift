//
//  Category.swift
//  ToDo
//
//  Created by Zach Benjamin on 4/3/18.
//  Copyright © 2018 Zach Benjamin. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name = ""
    let items = List<Item>()
}
