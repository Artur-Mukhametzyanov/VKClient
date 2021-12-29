//
//  Session.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 29.12.2021.
//

import Foundation

class Session {
    
    static let shared = Session()
    
    private init() {}
    
    var token: String?
    var userId: Int?
    
}
