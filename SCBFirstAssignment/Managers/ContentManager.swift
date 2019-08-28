//
//  ContentManager.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 28/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import UIKit

struct Mobile {
    var mobile : PurpleMobileResponse!
    var isFav : Bool!
}

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
                    let newMobile = Mobile(mobile: result[i], isFav: true)
                    self.allMobiles.append(newMobile)
                }
                completion(self.allMobiles)
            }
        }
    }
