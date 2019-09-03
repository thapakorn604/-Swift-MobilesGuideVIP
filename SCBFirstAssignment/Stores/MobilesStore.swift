//
//  AllStore.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Foundation

class MobilesStore: MobilesProtocol {
  func fetchImages(id: Int, _ completion: @escaping (Result<ImageResponse, Error>) -> Void) {
    NetworkManager.shared.feedImages(url: "https://scb-test-mobile.herokuapp.com/api/mobiles/\(id)/images/") { response in
      
      switch response {
      case let .success(result):
        completion(.success(result))
      case let .failure(error):
        completion(.failure(error))
      }
    }
  }
  
  func fetchFavourites(_ completion: @escaping ([Mobile]) -> Void) {
    let result = ContentManager.shared.favMobiles
    completion(result)
  }
  
  func fetchMobiles(_ completion: @escaping (Result<[Mobile], Error>) -> Void) {
    ContentManager.shared.loadContent { response in
      switch response {
      case let .success(result):
        completion(.success(result))
      case let .failure(error):
        completion(.failure(error))
      }
    }
  }
}
