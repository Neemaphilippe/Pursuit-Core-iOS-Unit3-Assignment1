//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Pursuit on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {

    var stockData = [AppData](){
        didSet{
          stockTableView.reloadData()
        }
    }
    
    
    @IBOutlet weak var stockTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        loadData()
        
    }
        
private func loadData(){
    guard let pathToJSONFile = Bundle.main.path(forResource: "applstockinfo", ofType: "json")else {
        return
    }
    let url = URL(fileURLWithPath: pathToJSONFile)
    do {
        let data = try Data(contentsOf: url)
        stockData = try AppData.getAppData(data: data)
    } catch {
            print(error)
        }
    
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let indexPath = stockTableView.indexPathForSelectedRow,
//            let destination = segue.destination as? DetailViewController else {return}
//
//        var stockToSendOver = stockData[indexPath.row]
////        destination.stock = stockToSendOver
//    }


}
extension StockViewController: UITabBarDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockcell", for: indexPath)
        var singleStock = stockData[indexPath.row]
        cell.textLabel?.text = "\(stockData[indexPath.row].date)"
        cell.detailTextLabel?.text = "\(stockData[indexPath.row].open)"
        return cell
    }
    
}
