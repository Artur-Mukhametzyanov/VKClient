//
//  AllGroupsInteractor.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 16.01.2022.
//

import Foundation
import Alamofire

class AllGroupsInteractor {
    
    func requestAllGroupsList(searchRequest: String, completion: @escaping (GroupsResponse) -> Void) {
        
        guard let token = Session.shared.token else {
            return
        }
        
        let url = "https://api.vk.com/method/groups.search"
        let parameters: Parameters = ["access_token": token,
                                      "q": searchRequest,
                                      "type": "group",
                                      "v": 5.131,
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

