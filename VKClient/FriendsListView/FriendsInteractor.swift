//
//  FriendsInteractor.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 16.01.2022.
//

import UIKit
import Alamofire
import RealmSwift

class FriendsInteractor {
    
    func requestFriendsList(completion: @escaping () -> Void) {
        
        guard let token = Session.shared.token else {
            return
        }
        
        let url = "https://api.vk.com/method/friends.get"
        let parameters: Parameters = ["access_token": token,
                                      "fields": "photo_100",
                                      "v": 5.131
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseData { rawData in
            do {
                guard let data = rawData.data else {return}
                let response = try JSONDecoder().decode(FriendResponse.self, from: data)
                
                let responseForRealm = response.response.items
                self.saveToRealm(data: responseForRealm)

            } catch {
                print(error)
            }
            completion()
        }
    }
    
    func saveToRealm(data: [FriendItem]) {
    do {
        let realm = try Realm()
        let oldFriends = realm.objects(FriendItem.self)
        realm.beginWrite()
        realm.delete(oldFriends)
        realm.add(data)
        try realm.commitWrite()
    } catch {
        print (error)
    }
    }
}

