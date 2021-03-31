//
//  Session.swift
//  VKClient
//
//  Created by Артур Мухаметзянов on 29.03.2021.
//

import Foundation

class Session {
    
    var token: String = ""
    var userId: Int = 0
    
    private init() {}
    static let sessionInstance = Session()
    
}

