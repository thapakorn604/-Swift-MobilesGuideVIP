//
//  ContentManager.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 28/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import UIKit

class ContentManager {
    var allMobiles = [Mobile]()
    var favMobiles = [Mobile]()

    static let shared = ContentManager()

    private init() {
    }

    func loadContent(completion: @escaping (Result<[Mobile], Error>) -> Void) {
        if allMobiles.count > 0 {
            completion(.success(self.allMobiles))
            return
        }

        NetworkManager.shared.feedMobiles(url: "https://scb-test-mobile.herokuapp.com/api/mobiles/") { (response) in
            switch response {
                case .success(let result):
                    for i in 0 ... result.count - 1 {
                        let newMobile = Mobile(mobile: result[i], isFav: false)
                        self.allMobiles.append(newMobile)
                    }
                    completion(.success(self.allMobiles))
                
                case .failure(let error):
                    completion(.failure(error))
            }
            
            }
        }

    func sortContent(by: Constants.sortingType, contentType: Constants.contentType) -> [Mobile] {
        switch by {
        case .priceDescending: sortByPriceDescending(contentType: contentType)
        case .priceAscending: sortByPriceAscending(contentType: contentType)
        case .rating: sortByRating(contentType: contentType)
        }

        return contentType == .allMobiles ? allMobiles : favMobiles
    }

    func sortByPriceAscending(contentType : Constants.contentType) { // stage is all content(0) for favourite contents(1)
        if contentType == .allMobiles {
            allMobiles = ContentManager.shared.allMobiles.sorted { $0.mobile.price < $1.mobile.price }
        } else {
            favMobiles = ContentManager.shared.favMobiles.sorted { $0.mobile.price < $1.mobile.price }
        }
    }

    func sortByPriceDescending(contentType : Constants.contentType) {
        if contentType == .allMobiles {
            allMobiles = ContentManager.shared.allMobiles.sorted { $0.mobile.price > $1.mobile.price }
        } else {
            favMobiles = ContentManager.shared.favMobiles.sorted { $0.mobile.price > $1.mobile.price }
        }
    }

    func sortByRating(contentType : Constants.contentType) {
        if contentType == .allMobiles {
            allMobiles = ContentManager.shared.allMobiles.sorted { $0.mobile.rating > $1.mobile.rating }
        } else {
            favMobiles = ContentManager.shared.favMobiles.sorted { $0.mobile.rating > $1.mobile.rating }
        }
    }
}
//
//switch result {
//case .success(let result):
//    for i in 0 ... result.count - 1 {
//        let newMobile = Mobile(mobile: result[i], isFav: false)
//        self.allMobiles.append(newMobile)
//    }
//    completion(self.allMobiles)
//case .failure(let error):
//    completion()
//}
