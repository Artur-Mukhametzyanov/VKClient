//
//  MyGroupsInteractor.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 16.01.2022.
//

import Foundation
import Alamofire

class MyGroupsInteractor {
    
    func requestMyGroupsList(completion: @escaping (GroupsResponse) -> Void) {
        
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
                completion(response)
            } catch {
                print(error)
            }
        }
    }
}
