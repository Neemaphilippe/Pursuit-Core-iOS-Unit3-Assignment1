//
//  DetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Pursuit on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
   
    var pictureSelected : PeopleInfo!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImage()
        setUpUI()

        // Do any additional setup after loading the view.
    }
    
    func setUpUI(){
        nameLabel.text = "\(pictureSelected.name.fullname.capitalized)"
        emailLabel.text = pictureSelected.email.capitalized
        locationLabel.text = "\(pictureSelected.location.city.capitalized)\(pictureSelected.location.state.capitalized)"
    }
    
    func setUpImage() {
        if let url = URL.init(string: pictureSelected.picture.large){
            do{
                let data = try Data.init(contentsOf: url)
                if let image = UIImage.init(data: data) {
                    imageView.image = image
                }
            }catch{
                print("the error with image \(error)")
            }
        }
        
    }

   
}
