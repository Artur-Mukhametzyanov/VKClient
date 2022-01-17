//
//  FriendsPhotosInteractor.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 16.01.2022.
//

import Foundation
import Alamofire

class FriendsPhotosInteractor {
    
    func requestFriendsPhotos(ownerId: Int) {
        
        guard let token = Session.shared.token else {
            return
        }
        
        let url = "https://api.vk.com/method/photos.getAll"
        let parameters: Parameters = ["access_token": token,
                                      "owner_id": ownerId,
                                      "v": 5.131
        ]
        
        AF.request(url, method: .get, parameters: parameters).response { response in
            print ("Список фотографий получен", response)
        }
    }
}
