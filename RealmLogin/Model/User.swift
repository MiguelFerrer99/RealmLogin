//
//  User.swift
//  RealmLogin
//
//  Created by Miguel Ferrer Fornali on 05/01/2021.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var email = ""
    @objc dynamic var firstname = ""
    @objc dynamic var lastname = ""
    @objc dynamic var password = ""
    @objc dynamic var online = "No"
    @objc dynamic var sex = ""
    @objc dynamic var photo:NSData?
    
    override static func primaryKey() -> String? {
        "email"
    }
}
