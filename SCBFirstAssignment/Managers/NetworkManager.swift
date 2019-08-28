//
//  NetworkManager.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func feedMobiles(url:String, completion:@escaping (([PurpleMobileResponse])->())) {
        
        AF.request(URL(string: url)!, method: .get).response { res in
            switch res.result {
            case .success:
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([PurpleMobileResponse].self, from: res.data!)
                    
                    completion(result)
                    
                } catch {
                    print(error)
                }
                
                break
            case let .failure(error):
                print(error)
                break
            }
        }
    }
}

