//
//  MyGroupsInteractor.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 16.01.2022.
//

import Foundation
import Alamofire
import RealmSwift

class MyGroupsInteractor {
    
    func requestMyGroupsList(completion: @escaping() -> Void) {
        
        guard let token = Session.shared.token else {
            return
        }
        
        let url = "https://api.vk.com/method/groups.get"
        let parameters: Parameters = ["access_token": token,
                                      "extended": "true",
                                      "v": 5.131
        ]
        
        AF.request(url, method: .get, parameters: parameters).response { rawData in
            do {
                guard let data = rawData.data else { return }
                let response = try JSONDecoder().decode(GroupsResponse.self, from: data)
                let responseForRealm = response.response.items
                self.saveToRealm(data: responseForRealm)

            } catch {
                print(error)
            }
            completion()
        }
    }
    
    func saveToRealm(data: [GroupsItems]) {
        do {
            let realm = try Realm()
            let oldGroups = realm.objects(GroupsItems.self)
            realm.beginWrite()
            realm.delete(oldGroups)
            realm.add(data)
            try realm.commitWrite()
        } catch {
            print (error)
        }
    }
}
