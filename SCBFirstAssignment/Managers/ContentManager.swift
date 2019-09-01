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
    
    private init(){
        
    }
    
    func loadContent(completion: @escaping ([Mobile]) -> ()) {
        if allMobiles.count > 0 {
            completion(allMobiles)
            return
        }
        
        NetworkManager.shared.feedMobiles(url: "https://scb-test-mobile.herokuapp.com/api/mobiles/") { (result) in
            for i in 0...result.count - 1 {
                    let newMobile = Mobile(mobile: result[i], isFav: false)
                    self.allMobiles.append(newMobile)
                }
                completion(self.allMobiles)
            }
        }
    
    func sortContent(by: Constants.sortingType, stage:Int) -> [Mobile] {
        
        switch by {
            case .priceDescending: sortByPriceDescending(stage: stage)
            case .priceAscending: sortByPriceAscending(stage: stage)
            case .rating: sortByRating(stage: stage)
        }
        
        return stage == 0 ? allMobiles : favMobiles
    }
    
    func sortByPriceAscending(stage:Int) { //stage is all content(0) for favourite contents(1)
        
        if stage == 0 {
            allMobiles = ContentManager.shared.allMobiles.sorted{$0.mobile.price < $1.mobile.price}
        } else {
            favMobiles = ContentManager.shared.favMobiles.sorted{$0.mobile.price < $1.mobile.price}
        }
    }
    
    func sortByPriceDescending(stage:Int) {
        
        if stage == 0 {
            allMobiles = ContentManager.shared.allMobiles.sorted{$0.mobile.price > $1.mobile.price}
        } else {
            favMobiles = ContentManager.shared.favMobiles.sorted{$0.mobile.price > $1.mobile.price}
        }
    }
    
    func sortByRating(stage:Int) {
        
        if stage == 0 {
            allMobiles = ContentManager.shared.allMobiles.sorted{$0.mobile.rating > $1.mobile.rating}
        } else {
            favMobiles = ContentManager.shared.favMobiles.sorted{$0.mobile.rating > $1.mobile.rating}
        }
    }
    
}

