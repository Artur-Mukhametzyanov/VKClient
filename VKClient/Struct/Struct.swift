//
//  Struct.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 09.11.2020.
//

import UIKit

class MyFriendsStruct {
    
    var friendsName: String
    var friendsPhoto: UIImage
    var friendsID: Int
    
    init(friendsName: String, friendsPhoto: UIImage, friendsID: Int) {
        self.friendsName = friendsName
        self.friendsPhoto = friendsPhoto
        self.friendsID = friendsID
    }
}

class GroupsStruct: Equatable {
    
    var groupName: String
    var groupPhoto: UIImage
    
    init(groupName: String, groupPhoto: UIImage) {
        self.groupName = groupName
        self.groupPhoto = groupPhoto
    }
    
    static func == (lhs: GroupsStruct, rhs: GroupsStruct) -> Bool {
        return lhs.groupName == rhs.groupName
    }
}
