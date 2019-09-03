//
//  NetworkManager.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Alamofire
import Foundation
import Network

class NetworkManager {
    static let shared = NetworkManager()

    func feedMobiles(url: String, completion: @escaping ((Result<[PurpleMobileResponse], Error>) -> Void)) {
        AF.request(URL(string: url)!, method: .get).response { res in
            switch res.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([PurpleMobileResponse].self, from: res.data!)

                    completion(.success(result))

                } catch {
                    completion(.failure(error))
                    print(error)
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func feedImages(url: String, completion: @escaping ((Result<[PurpleImageResponse], Error>) -> Void)) {
        AF.request(URL(string: url)!, method: .get).response { res in
            switch res.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([PurpleImageResponse].self, from: res.data!)

                    completion(.success(result))

                } catch {
                    print(error)
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func canOpenURL(_ string: String?) -> Bool {
        guard let urlString = string,
            let url = URL(string: urlString)
        else { return false }

        if !UIApplication.shared.canOpenURL(url) { return false }

        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regEx])
        return predicate.evaluate(with: string)
    }

    func isReachingInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
