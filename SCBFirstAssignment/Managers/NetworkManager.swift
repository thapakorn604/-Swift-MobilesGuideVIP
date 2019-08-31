//
//  NetworkManager.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import Alamofire
import Network

enum Result<T> {
    case success(T)
    case failure(Error)
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    
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
    
    func feedImages(url:String, completion:@escaping (([PurpleImageResponse])->())) {
        
        AF.request(URL(string: url)!, method: .get).response { res in
            switch res.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([PurpleImageResponse].self, from: res.data!)
                    
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
    
    func canOpenURL(_ string: String?) -> Bool {
        guard let urlString = string,
            let url = URL(string: urlString)
            else { return false }
        
        if !UIApplication.shared.canOpenURL(url) { return false }
        
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    
    func isReachingInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

