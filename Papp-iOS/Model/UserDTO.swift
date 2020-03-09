//
//  UserDTO.swift
//  Papp
//
//  Created by Nikolaj Wassmann on 17/02/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import Foundation

struct UserDTO: Decodable {
    
    var name: String
    var email: String
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}
