//
//  applstockinfo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Pursuit on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

struct AppData : Codable{
    let date: String
    let open: Double
    let close: Double
    
    var day: String {
        return date.components(separatedBy: "-")[2]
    }
    var month: String {
        return date.components(separatedBy: "-")[1]
    }
    var year: String {
        return date.components(separatedBy: "-")[0]
    }
    
    static func getAppData() -> [AppData] {
        
        guard let fileName = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {fatalError()}
               let fileURL = URL(fileURLWithPath: fileName)
               do {
                   let data = try Data(contentsOf: fileURL)
                   let getAppDataInfo = try JSONDecoder().decode([AppData].self, from: data)
                    return getAppDataInfo
            
        }catch{
             fatalError()
        }
    }
    
    
    static func getSortedStocks() -> [StocksSorted] {
        let stocksForAppData = AppData.getAppData().sorted()
        var sortedStocks = [StocksSorted]()
        let years = Set(stocksForAppData.map({$0.year}))
        let months = Set(stocksForAppData.map({$0.month}))
    
        
        
      
           
                
            
                
                for year in years {
                    for month in months {
                        let filteredStocks = stocksForAppData.filter{$0.year == year && $0.month == month}
                        if filteredStocks.count > 0 {
                            let newStocksByMonthAndYear = StocksSorted(month: month, year: year, stocks: filteredStocks)
                           
                                sortedStocks.append(newStocksByMonthAndYear)
                                                           
                            
                        }
                        }
                    
                }
            return sortedStocks
        }
        
        
        
}
       
            
      
    

public struct GetImages {
    let goodImage: UIImage = (UIImage(named: "thumbsUp")!)
    let badImage: UIImage = (UIImage(named: "thumbsDown")!)
}
extension AppData: Comparable {
    static func < (lhs: AppData, rhs: AppData) -> Bool {
        if Int(lhs.year)! < Int(rhs.year)! {
            return true
        } else if Int(lhs.year)! > Int(rhs.year)! {
            return false
        } else {
            if Int(lhs.month)! < Int(rhs.month)! {
                return true
            } else if Int(lhs.month)! > Int(rhs.month)! {
                return false
            } else {
                if Int(lhs.day)! < Int(rhs.day)! {
                    return true
                } else if Int(lhs.day)! > Int(rhs.day)! {
                    return false
                } else {
                    return true
                }
            }
        }
    }
}
struct StocksSorted {
    let month: String
    let year: String
    let stocks: [AppData]
    init(month: String, year: String, stocks:[AppData]){
        self.month = month
        self.year = year
        self.stocks = stocks.sorted()
        
    }
    func getMonthAverage() -> Double {
        return stocks.reduce(0, { (intermediateResult, stock) -> Double in
            intermediateResult + stock.open
        }) / Double(stocks.count)
    }
}
