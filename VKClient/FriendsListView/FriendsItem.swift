//
//  FriendsItem.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 01.12.2021.
//

import Foundation
import RealmSwift

struct FriendResponse: Codable {
    let response: Response
}

struct Response: Codable {
    let items: [FriendItem]
}

class FriendItem: Object, Codable {
    
    @objc dynamic var userId: Int
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String
    @objc dynamic var friendsImageLink: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case friendsImageLink = "photo_100"
    }
}
