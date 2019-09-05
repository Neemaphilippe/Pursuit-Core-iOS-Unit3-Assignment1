//
//  applstockinfo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Pursuit on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct AppData : Codable {
    let date: String
    let open: String
    let close: String
    
    static func getAppData(data: Data) throws -> [AppData] {
        do {
            let getAppDataInfo = try JSONDecoder().decode([AppData].self, from: data)
            return getAppDataInfo
            
        }catch{
            throw error
        }
    }
}
