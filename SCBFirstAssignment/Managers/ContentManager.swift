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
    
    NetworkManager.shared.feedMobiles(url: Constants.UrlType.mobiles) { [weak self] response in
      switch response {
      case .success(let result):
        for i in 0 ... result.count - 1 {
          let newMobile = Mobile(mobile: result[i], isFav: false)
          self?.allMobiles.append(newMobile)
        }
        completion(.success(self!.allMobiles))
        
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
