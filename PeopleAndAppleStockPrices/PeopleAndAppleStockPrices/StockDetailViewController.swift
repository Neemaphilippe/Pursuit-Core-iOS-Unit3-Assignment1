//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Pursuit on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {

    var stockSelected : AppData!
    var accessImage : GetImages!
    
    
    @IBOutlet weak var stockImage: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var openLabel: UILabel!
    
    @IBOutlet weak var closeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStockUI()
        setUpImages()
        setBackgroundColor()
        

    }
    
    func setUpStockUI() {
        dateLabel.text = "Date: \(stockSelected.date)"
        openLabel.text = "Open: \(stockSelected.open)"
//            String(stockSelected.open)
        closeLabel.text =  "Close: \(stockSelected.close)"
    }
    func setUpImages() {
        if stockSelected.open > stockSelected.close {
            stockImage.image = UIImage(named: "thumbsUp")
            
        }else {
            stockImage.image = UIImage(named: "thumbsDown")
        }
    
}
    func setBackgroundColor(){
        if stockImage.image == UIImage(named:"thumbsUp"){
           self.view.backgroundColor = UIColor.green
        }else{
            if stockImage.image == UIImage(named:"thumbsDown"){
               self.view.backgroundColor = UIColor.red
        }
    }
            
}
}
