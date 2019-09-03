//
//  FavouritePresenter.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol FavouritePresenterInterface {
  func presentFavourites(response: Favourite.FavMobiles.Response)
}

class FavouritePresenter: FavouritePresenterInterface {
  weak var viewController: FavouriteViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentFavourites(response: Favourite.FavMobiles.Response) {
    var displayedFavourites: [Favourite.FavMobiles.ViewModel.DisplayedFavourite] = []
    for favMobile in response.favMobiles {
      // print(mobile)
      let id = favMobile.mobile.id
      let name = favMobile.mobile.name
      let description = favMobile.mobile.description
      let price = "Price: \(favMobile.mobile.price)"
      let rating = "Rating: \(favMobile.mobile.rating)"
      let thumbImageURL = favMobile.mobile.thumbImageURL
      
      let favMobile = Favourite.FavMobiles.ViewModel.DisplayedFavourite(id: id, name: name, description: description, price: price, rating: rating, thumbImageURL: thumbImageURL)
      displayedFavourites.append(favMobile)
    }
    let viewModel = Favourite.FavMobiles.ViewModel(displayedFavourites: displayedFavourites)
    print(viewModel)
    viewController?.displayFavourites(viewModel: viewModel)
  }
}
