//
//  FavouriteInteractor.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol FavouriteInteractorInterface {
  func loadContent(request: Favourite.FavMobiles.Request)
  func sortContent(request: Favourite.SortFavs.Request)
  func deleteFavourite(request: Favourite.DeleteFav.Request)
  var favMobiles: [Mobile] { get }
}

class FavouriteInteractor: FavouriteInteractorInterface {
  
  var presenter: FavouritePresenterInterface!
  var worker: MobilesWorker?
  var favMobiles: [Mobile] = []
  
  // MARK: - Business logic
  
  func loadContent(request: Favourite.FavMobiles.Request) {
    worker?.fetchFavourites { [weak self] result in
      self?.favMobiles = result
      
      let response = Favourite.FavMobiles.Response(favMobiles: result)
      self?.presenter.presentFavourites(response: response)
    }
  }
  
  func sortContent(request: Favourite.SortFavs.Request) {
    switch request.sortingType {
      case .priceDescending: sortByPriceDescending()
      case .priceAscending: sortByPriceAscending()
      case .rating: sortByRating()
    }
    let response = Favourite.FavMobiles.Response(favMobiles: favMobiles)
    presenter.presentFavourites(response: response)
  }
  
  func sortByPriceAscending() {
    ContentManager.shared.favMobiles = ContentManager.shared.favMobiles.sorted { $0.mobile.price < $1.mobile.price }
    self.favMobiles = ContentManager.shared.favMobiles
  }
  
  func sortByPriceDescending() {
    ContentManager.shared.favMobiles = ContentManager.shared.favMobiles.sorted { $0.mobile.price > $1.mobile.price }
    self.favMobiles = ContentManager.shared.favMobiles
  }
  
  func sortByRating() {
    ContentManager.shared.favMobiles = ContentManager.shared.favMobiles.sorted { $0.mobile.rating > $1.mobile.rating }
    self.favMobiles = ContentManager.shared.favMobiles
  }
  
  func deleteFavourite(request: Favourite.DeleteFav.Request) {
    if let index = ContentManager.shared.favMobiles.firstIndex(where: { $0.mobile.id == request.id }) {
      ContentManager.shared.favMobiles.remove(at: index)
    }
    
    if let mobileIndex = ContentManager.shared.allMobiles.firstIndex(where: { $0.mobile.id == request.id }) {
      ContentManager.shared.allMobiles[mobileIndex].isFav = false
    }
    
    favMobiles = ContentManager.shared.favMobiles
    let response = Favourite.FavMobiles.Response(favMobiles: favMobiles)
    presenter.presentDeletedFavourite(response: response)
  }
}
