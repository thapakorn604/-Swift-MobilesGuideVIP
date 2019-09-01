//
//  AllWorker.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Foundation
import Alamofire
import Network

protocol MobilesProtocol {
  func getData(_ completion: @escaping ([Mobile]) -> Void)
}

class MobilesWorker {

  var store: MobilesStore
  //var mobiles = [Mobile]()

  init(store: MobilesStore) {
    self.store = store
  }

  // MARK: - Business Logic

  func fetchMobiles(_ completion: @escaping ([Mobile]) -> Void) {
    ContentManager.shared.loadContent { (response) in
        completion(response)
    }
  }
    func fetchFavourites(_ completion: @escaping ([Mobile]) -> Void) {
        // NOTE: Do the work
        let result = ContentManager.shared.favMobiles
        completion(result)
    }
    
    func sortMobiles(sortingType: Constants.sortingType, stage: Int, _ completion: @escaping ([Mobile]) -> Void) {
        let result = ContentManager.shared.sortContent(by: sortingType, stage: stage)
        
        completion(result)
    }
}
