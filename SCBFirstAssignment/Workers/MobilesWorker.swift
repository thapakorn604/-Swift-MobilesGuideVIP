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
  func fetchMobiles(_ completion: @escaping (Result<[Mobile], Error>) -> Void)
}

class MobilesWorker {

  var store: MobilesStore

  init(store: MobilesStore) {
    self.store = store
  }

  // MARK: - Business Logic

  func fetchMobiles( _ completion: @escaping (Result<[Mobile], Error>) -> Void) {
    store.fetchMobiles(completion)
  }
    func fetchFavourites(_ completion: @escaping ([Mobile]) -> Void) {
        // NOTE: Do the work
        let result = ContentManager.shared.favMobiles
        completion(result)
    }
    
    func fetchImages(id : Int, _ completion: @escaping(Result<ImageResponse, Error>) -> Void) {
        NetworkManager.shared.feedImages(url: "https://scb-test-mobile.herokuapp.com/api/mobiles/\(id)/images/") { (response) in
            
            switch response {
            case .success(let result):
                completion(.success(result))
            case . failure(let error):
                completion(.failure(error))
            }
        }
    }
}
