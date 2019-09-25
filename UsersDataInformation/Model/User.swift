//
//  User.swift
//  UsersDataInformation
//
//  Created by Eva on 9/23/19.
//  Copyright © 2019 Eva. All rights reserved.
//


import UIKit
import Foundation

struct User: Codable {

    let page:  Int
    let per_page:  Int
    let total:  Int
    let total_pages:  Int
    let data: [UserDataForm]


}

struct UserDataForm: Codable {
    
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case first_name
        case last_name
        case avatar
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try! container.decode(Int.self, forKey: .id)
        self.email = try! container.decode(String.self, forKey: .email)
        self.first_name = try! container.decode(String.self, forKey: .first_name)
        self.last_name = try! container.decode(String.self, forKey: .last_name)
        
        //self.last_name = try? container.decode(String.self, forKey: .last_names)
        self.avatar  = try! container.decode(String.self, forKey: .avatar)
        
        
    }
    
    
}


