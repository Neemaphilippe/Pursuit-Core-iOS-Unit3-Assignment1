//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var singleUser = [PeopleInfo]() {
    didSet {
    userInfoData.reloadData()
    }
}
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
  
    
    var searchString: String? = nil {
        didSet {
            print(searchString!)
            self.userInfoData.reloadData()
        }
    }
    
    
    @IBOutlet weak var userInfoData: UITableView!
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setProtocols()
        getData()
       
    
        
    }
    private var pictures = [UIImage]() {
        didSet {
            DispatchQueue.main.async {
                self.userInfoData.reloadData()
            }
        }
    }

    func getData() {
        UserAPIClient.getInfo(completionHandler: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error.errorMessage())
                    
                case .success(let data):
                    self.singleUser = data.sorted(by: { (name, name2) -> Bool in
                        name.name.first < name2.name.first
                    })
                
                }
            }
        }
        )}
    
    
  
    
    
    func setProtocols() {
        userInfoData.dataSource = self
        userInfoData.delegate = self
        searchBar.delegate = self
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = userInfoData.indexPathForSelectedRow,
            let destination = segue.destination as? DetailViewController else {return}
        
        var dataToSend = singleUser[indexPath.row]
        destination.pictureSelected = dataToSend
    }
    
    
    func searchPerson(keyword: String) -> [PeopleInfo]{
        var userSearchResults : [PeopleInfo] {
            get {
                guard let searchString = searchString else {
                    return singleUser
                }
                guard searchString != "" else {
                    return singleUser
                }
                let results = singleUser.filter{$0.name.fullname.lowercased().contains(searchString.lowercased())}
                if results.count == 0 {
                    return []
                }else {
                    return singleUser.filter{$0.name.fullname.lowercased().contains(searchString.lowercased())}
                }
            }
        }
        return userSearchResults
    }
}
        
    extension ViewController : UITableViewDelegate, UITableViewDataSource {
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return searchPerson(keyword: searchString ?? "").count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "userinfocell", for: indexPath)
                let userInfo = searchPerson(keyword: searchString ?? "")[indexPath.row]
//                let picturesPassed = pictures[indexPath.row]
                
              var dataToSet = singleUser[indexPath.row]
         cell.textLabel?.text = "\(userInfo.name.first.capitalized) \(userInfo.name.last.capitalized)"
          
                cell.detailTextLabel?.text = "\(userInfo.location.street.capitalized) \(userInfo.location.city.capitalized) \(userInfo.location.state.capitalized)"
                return cell
            }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
            
        }
        }
    
    
    
    extension ViewController : UISearchBarDelegate {
         func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchString = searchBar.text
            searchPerson(keyword: searchString!)
//              searchString = searchBar.text
            
            
           
        }
        
}



