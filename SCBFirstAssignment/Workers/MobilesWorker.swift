//
//  AllWorker.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Alamofire
import Foundation
import Network

protocol MobilesProtocol {
  func fetchMobiles(_ completion: @escaping (Result<[Mobile], Error>) -> Void)
  func fetchFavourites(_ completion: @escaping ([Mobile]) -> Void)
  func fetchImages(id: Int, _ completion: @escaping (Result<ImageResponse, Error>) -> Void)
}

class MobilesWorker {
  var store: MobilesStore
  init(store: MobilesStore) {
    self.store = store
  }
  
  func fetchMobiles(_ completion: @escaping (Result<[Mobile], Error>) -> Void) {
    store.fetchMobiles(completion)
  }
  
  func fetchFavourites(_ completion: @escaping ([Mobile]) -> Void) {
    store.fetchFavourites(completion)
  }
  
  func fetchImages(id: Int, _ completion: @escaping (Result<ImageResponse, Error>) -> Void) {
    store.fetchImages(id: id, completion)
  }
}
