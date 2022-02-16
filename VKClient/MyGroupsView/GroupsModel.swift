//
//  GroupsModel.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 01.12.2021.
//

import UIKit

struct Group {
    var groupsImage: UIImage
    var groupsName: String
}

struct GroupsResponse: Codable {
    let response: MyGroupsResponse
}

struct MyGroupsResponse: Codable {
    let items: [GroupsItems]
}

struct GroupsItems: Codable {
    let groupName: String
    let groupPhoto: String
    
    enum CodingKeys: String, CodingKey {
        case groupName = "name"
        case groupPhoto = "photo_100"
    }
}
