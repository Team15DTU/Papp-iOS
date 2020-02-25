//
//  UserDTO.swift
//  Papp
//
//  Created by Nikolaj Wassmann on 17/02/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import Foundation

//Temp UserDTO object

struct UserDTO: Decodable {
    
    var name: String
    var email: String
    var password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
}
