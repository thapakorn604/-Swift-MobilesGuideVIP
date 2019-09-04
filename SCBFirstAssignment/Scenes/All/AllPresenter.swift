//
//  AllPresenter.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol AllPresenterInterface {
  func presentMobiles(response: All.FetchMobiles.Response)
}

class AllPresenter: AllPresenterInterface {
  weak var viewController: AllViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentMobiles(response: All.FetchMobiles.Response) {
    var displayedMobiles: [All.FetchMobiles.ViewModel.DisplayedMobile] = []
    let content : Content<[All.FetchMobiles.ViewModel.DisplayedMobile]>
    
    switch response.content {
    case .success(let mobiles):
      for mobile in mobiles {
        // print(mobile)
        let id = mobile.mobile.id
        let name = mobile.mobile.name
        let description = mobile.mobile.description
        let price = "Price: $\(mobile.mobile.price)"
        let rating = "Rating: \(mobile.mobile.rating)"
        let thumbImageURL = mobile.mobile.thumbImageURL
        let isFav = mobile.isFav
        
        let mobile = All.FetchMobiles.ViewModel.DisplayedMobile(id: id, name: name, description: description, price: price, rating: rating, thumbImageURL: thumbImageURL, isFav: isFav)
        displayedMobiles.append(mobile)
      }
      content = .success(data: displayedMobiles)
    case .error(let error):
      content = .error(error)
    }
    
    let viewModel = All.FetchMobiles.ViewModel(displayedMobiles: content)
    viewController?.displayMobiles(viewModel: viewModel)
  }
}
