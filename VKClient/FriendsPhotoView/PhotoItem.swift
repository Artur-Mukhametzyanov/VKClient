//
//  PhotoItem.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 05.02.2022.
//

import Foundation

struct PhotoResponse: Codable {
    var response: FriendsPhotoResponse
}

struct FriendsPhotoResponse: Codable {
    var items: [PhotoItems]
}

struct PhotoItems: Codable {
    var sizes: [PhotoInfo]
}

struct PhotoInfo: Codable {
    var type: String
    var photoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case photoUrl = "url"
    }
}
