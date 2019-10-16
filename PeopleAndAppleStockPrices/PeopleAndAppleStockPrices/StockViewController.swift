//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Pursuit on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {

    var stocksAndSections = [StocksSorted](){
        didSet{
            DispatchQueue.main.async {
                
            
                self.stockTableView.reloadData()
        }
        }
    }
    
//    var stockData = [AppData](){
//        didSet{
//          stockTableView.reloadData()
//        }
//    }
    
    
    @IBOutlet weak var stockTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        stockTableView.delegate = self
       loadData()
       
        
    }
    
    private func loadData(){
        DispatchQueue.global().async {
            
        
        self.stocksAndSections = AppData.getSortedStocks()
        }
        
    }
    
        
//private func loadData(){
//    guard let pathToJSONFile = Bundle.main.path(forResource: "applstockinfo", ofType: "json")else {
//        return
//    }
//    let url = URL(fileURLWithPath: pathToJSONFile)
//    do {
//        let data = try Data(contentsOf: url)
//        stockData = try AppData.getAppData()
//    } catch {
//            print(error)
//        }
//
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = stockTableView.indexPathForSelectedRow,
            let destination = segue.destination as? StockDetailViewController else {return}

        var stockToSendOver = stocksAndSections[indexPath.section].stocks[indexPath.row]
        
        destination.stockSelected = stockToSendOver
    }


}
extension StockViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return stocksAndSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksAndSections[section].stocks.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           let stock = stocksAndSections[section]
           return "\(stock.month) \(stock.year).AVG: \(stock.getMonthAverage())"
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stock = stocksAndSections[indexPath.section].stocks[indexPath.row]
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockcell", for: indexPath)
       cell.textLabel?.text = "\(stock.day) \(stock.month) \(stock.year)"
       cell.detailTextLabel?.text = "\(stock.open)"
        return cell
    }
    
}
