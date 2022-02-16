//
//  FriendsItem.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 01.12.2021.
//

import UIKit

//struct Friend {
//    let userId: Int
//    let firstName: String
//    let lastName: String
//    let friendsImage: UIImage
//}

struct FriendResponse: Codable {
    let response: Response
}

struct Response: Codable {
    let items: [FriendItem]
}

struct FriendItem: Codable {
    let userId: Int
    let firstName: String
    let lastName: String
    let friendsImageLink: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case friendsImageLink = "photo_100"
    }
}
