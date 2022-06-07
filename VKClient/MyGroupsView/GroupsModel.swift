//
//  GroupsModel.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 01.12.2021.
//

import Foundation
import RealmSwift

struct GroupsResponse: Codable {
    let response: MyGroupsResponse
}

struct MyGroupsResponse: Codable {
    let items: [GroupsItems]
}

class GroupsItems: Object, Codable {
    
    @objc dynamic var groupName: String
    @objc dynamic var groupPhoto: String
    
    enum CodingKeys: String, CodingKey {
        case groupName = "name"
        case groupPhoto = "photo_100"
    }
}
