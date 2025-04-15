//
//  Profile.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-15.
//

import Foundation
import SwiftData


@Model
class Profile {
    var userId: String
    var email: String
    var name: String
    
    
    init(id: UUID, email: String, name: String) {
        self.id = id
        self.email = email
        self.name = name
    }
}

