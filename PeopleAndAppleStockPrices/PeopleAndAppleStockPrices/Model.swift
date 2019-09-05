//
//  Model.swift
//  PeopleAndAppleStockPrices
//
//  Created by Pursuit on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

public enum PossibleError : Error {
    case badURL(String)
    case networkError(Error)
    case decodingError(Error)
    
    
    public func errorMessage() -> String {
        switch self {
        case.badURL(let message):
            return "badURL: \(message)"
        case .networkError(let error):
            return "networkError: \(error)"
        case .decodingError(let error):
            return "decoding error: \(error)"
        }
    }
    
}
final class UserAPIClient {
    static func getInfo(completionHandler: @escaping ((Result<[PeopleInfo], PossibleError>)-> Void)){
        let urlString = "https://randomuser.me/api/?results=50"
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL("error")))
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                completionHandler(.failure(.badURL("bad url")))
            } else if let data = data {
                do {
                    let searchData = try JSONDecoder().decode(UserInfoData.self, from: data)
                    completionHandler(.success(searchData.results))
                    
                    
                }catch let jsonError {
                    completionHandler(.failure(.networkError(jsonError)))
                }
            }
        }.resume()
    }
}





// a bit confused about the difference between using info from the internet and using the json with the completion handler stuff
