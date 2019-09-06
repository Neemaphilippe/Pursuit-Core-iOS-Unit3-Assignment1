//
//  applstockinfo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Pursuit on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

struct AppData : Codable {
    let date: String
    let open: Double
    let close: Double
    
    static func getAppData(data: Data) throws -> [AppData] {
        do {
            let getAppDataInfo = try JSONDecoder().decode([AppData].self, from: data)
            return getAppDataInfo
            
        }catch{
            throw error
        }
    }
}
public struct GetImages {
    let goodImage: UIImage = (UIImage(named: "thumbsUp")!)
    let badImage: UIImage = (UIImage(named: "thumbsDown")!)
}
