//
//  userinfo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Pursuit on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct UserInfoData : Codable {
    let results : [PeopleInfo]
    
    static func getUserInfo(data: Data) throws -> [PeopleInfo] {
        do {
            let userInfoData = try JSONDecoder().decode(UserInfoData.self, from: data)
            
            return userInfoData.results.sorted(by: { (name, name2) -> Bool in
                name.name.first < name2.name.first
            })
        }catch{
            throw error
        }
    }
}



struct PeopleInfo : Codable {
    let name : NameData
    let location : LocationData?
    let picture : PictureData
    let email: String
}

struct NameData : Codable {
    let first : String
    let last : String
    var fullname : String {
        return "\(first) \(last)"
    }
    
    func sortOut(users: [PeopleInfo]) -> String {
        let sorted = users.sorted { $0.name.first < $1.name.first }
        return "\(sorted)"
    }
}

struct LocationData : Codable {
    let street : String?
    let city : String?
    let state : String?
}
struct PictureData: Codable {
    let large : String
    let medium : String
}

