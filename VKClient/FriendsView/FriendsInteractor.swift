//
//  FriendsInteractor.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 16.01.2022.
//

import UIKit
import Alamofire

class FriendsInteractor {
    
    func requestFriendsList() {
        
        guard let token = Session.shared.token else {
            return
        }
        
        let url = "https://api.vk.com/method/friends.get"
        let parameters: Parameters = ["access_token": token,
                                      "fields": "photo_100",
                                      "v": 5.131
        ]
        
        AF.request(url, method: .get, parameters: parameters).response { response in
            print ("Список друзей получен", response)
        }
    }
}
