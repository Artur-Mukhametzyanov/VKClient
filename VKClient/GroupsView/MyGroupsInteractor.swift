//
//  MyGroupsInteractor.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 16.01.2022.
//

import Foundation
import Alamofire

class MyGroupsInteractor {
    
    func requestMyGroupsList() {
        
        guard let token = Session.shared.token else {
            return
        }
        
        let url = "https://api.vk.com/method/groups.get"
        let parameters: Parameters = ["access_token": token,
                                      "extended": "true",
                                      "v": 5.131
        ]
        
        AF.request(url, method: .get, parameters: parameters).response { response in
            print ("Список моих групп получен", response)
        }
    }
}
