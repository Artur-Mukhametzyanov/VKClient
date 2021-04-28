//
//  Struct.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 09.11.2020.
//

import UIKit
import RealmSwift

class MyFriendsStruct: Object {
    
    @objc dynamic var friendsName = ""
    @objc dynamic var friendsPhotoURL = ""
    @objc dynamic var friendsID = 0
    
//    override static func primaryKey() -> String? {
//        return "friendsID"
//    }

}

class GroupsStruct: Object {
    
    @objc dynamic var groupName = ""
    @objc dynamic var groupPhotoURL = ""

    static func == (lhs: GroupsStruct, rhs: GroupsStruct) -> Bool {
        return lhs.groupName == rhs.groupName
    }
}
