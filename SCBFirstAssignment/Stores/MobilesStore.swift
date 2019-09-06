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
    let imageUrl = Constants.UrlType.images
    let url = String(format: imageUrl, id)
    
    NetworkManager.shared.feedImages(url: url) { response in
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

class MobilesMockStore: MobilesProtocol {
  func fetchMobiles(_ completion: @escaping (Result<[Mobile], Error>) -> Void) {
    let mobiles : [Mobile] = [
      Mobile(mobile: PurpleMobileResponse(description: "a", id: 1, price: 1, brand: "a", rating: 1.0, thumbImageURL: "a", name: "a"),
             isFav: false),
      Mobile(mobile: PurpleMobileResponse(description: "b", id: 2, price: 2, brand: "b", rating: 2.0, thumbImageURL: "b", name: "b"), isFav: false),
      Mobile(mobile: PurpleMobileResponse(description: "c", id: 3, price: 3, brand: "c", rating: 3.0, thumbImageURL: "c", name: "c"), isFav: false)
    ]
    
    completion(.success(mobiles))
  }
  
  func fetchFavourites(_ completion: @escaping ([Mobile]) -> Void) {
    let favMobiles : [Mobile] = [
      Mobile(mobile: PurpleMobileResponse(description: "a", id: 1, price: 1, brand: "a", rating: 1.0, thumbImageURL: "a", name: "a"),
             isFav: true),
      Mobile(mobile: PurpleMobileResponse(description: "b", id: 2, price: 2, brand: "b", rating: 2.0, thumbImageURL: "b", name: "b"), isFav: true),
      Mobile(mobile: PurpleMobileResponse(description: "c", id: 3, price: 3, brand: "c", rating: 3.0, thumbImageURL: "c", name: "c"), isFav: true)
    ]
    
    completion(favMobiles)
  }
  
  func fetchImages(id: Int, _ completion: @escaping (Result<ImageResponse, Error>) -> Void) {
    let mockImages : ImageResponse = [
      PurpleImageResponse(url: "a", id: 1, mobileID: 1),
      PurpleImageResponse(url: "b", id: 2, mobileID: 1),
      PurpleImageResponse(url: "c", id: 3, mobileID: 1)]
    
    completion(.success(mockImages))
  }
}
