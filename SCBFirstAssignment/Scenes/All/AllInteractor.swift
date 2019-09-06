//
//  AllInteractor.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol AllInteractorInterface {
  func loadContent(request: All.FetchMobiles.Request)
  func sortContent(request: All.SortMobiles.Request)
  func updateFavourite(request: All.UpdateFavourite.Request)
  var mobiles: [Mobile] { get set }
}

class AllInteractor: AllInteractorInterface {
  
  var mobiles: [Mobile] = []
  var presenter: AllPresenterInterface!
  var worker: MobilesWorker?
  
  func loadContent(request: All.FetchMobiles.Request) {
    
    worker?.fetchMobiles { [weak self] response in
      
      switch response {
      case .success(let result):
        self?.mobiles = result
        let content: Content<[Mobile]> = .success(data: result)
        let response = All.FetchMobiles.Response(content: content)
        self?.presenter.presentMobiles(response: response)
      case .failure(let error):
        let content: Content<[Mobile]> = .error(error.localizedDescription)
        let response = All.FetchMobiles.Response(content: content)
        self?.presenter.presentMobiles(response: response)
      }
    }
  }
  
  func sortContent(request: All.SortMobiles.Request) {
    
    switch request.sortingType {
    case .priceDescending:
      self.mobiles = sortByPriceDescending(self.mobiles)
      ContentManager.shared.allMobiles = self.mobiles
    case .priceAscending:
      self.mobiles = sortByPriceAscending(self.mobiles)
      ContentManager.shared.allMobiles = self.mobiles
    case .rating:
      self.mobiles = sortByRating(self.mobiles)
      ContentManager.shared.allMobiles = self.mobiles
    }
    let content : Content<[Mobile]> = .success(data: self.mobiles)
    let response = All.FetchMobiles.Response(content: content)
    self.presenter.presentMobiles(response: response)
  }
  
  func sortByPriceAscending(_ list : [Mobile]) -> [Mobile] {
    return list.sorted { $0.mobile.price < $1.mobile.price }
  }
  
  func sortByPriceDescending(_ list : [Mobile]) -> [Mobile] {
    return list.sorted { $0.mobile.price > $1.mobile.price }
  }
  
  func sortByRating(_ list: [Mobile]) -> [Mobile] {
    return list.sorted { $0.mobile.rating > $1.mobile.rating }
  }
  
  func updateFavourite(request: All.UpdateFavourite.Request) {
    
    guard let index = mobiles.firstIndex(where: { $0.mobile.id == request.id }) else { return }
    let element = mobiles[index]
    
    if !element.isFav {
      mobiles[index].isFav = true
      ContentManager.shared.favMobiles.append(element)
    } else {
      mobiles[index].isFav = false
      if let favIndex = ContentManager.shared.favMobiles.firstIndex(where: { $0.mobile.id == request.id }) {
        ContentManager.shared.favMobiles.remove(at: favIndex)
      }
    }
    
    ContentManager.shared.allMobiles = mobiles
    
    let content : Content<[Mobile]> = .success(data: self.mobiles)
    let response = All.FetchMobiles.Response(content: content)
    self.presenter.presentMobiles(response: response)
  }
 }

