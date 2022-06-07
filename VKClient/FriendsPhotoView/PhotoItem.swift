//
//  PhotoItem.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 05.02.2022.
//

import Foundation
import RealmSwift

struct PhotoResponse: Codable {
    var response: FriendsPhotoResponse
}

struct FriendsPhotoResponse: Codable {
    var items: [PhotoItems]
}

struct PhotoItems: Codable {
    var sizes: [PhotoInfo]
}

class PhotoInfo: Object, Codable {
    
    @objc dynamic var type: String
    @objc dynamic var photoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case photoUrl = "url"
    }
}
