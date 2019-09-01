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

protocol AllStoreProtocol {
  func getData(_ completion: @escaping ([Mobile]) -> Void)
}

class MobilesWorker {

  var store: AllStoreProtocol
    var mobiles = [Mobile]()

  init(store: AllStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic

  func fetchMobiles(_ completion: @escaping ([Mobile]) -> Void) {
    ContentManager.shared.loadContent { (response) in
        //print(response)
        completion(response)
    }
  }
}

