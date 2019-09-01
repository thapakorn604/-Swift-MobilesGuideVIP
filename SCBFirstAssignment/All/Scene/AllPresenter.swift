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
    
    //print(response)
    print("Yeah")
    
    var displayedMobiles: [All.FetchMobiles.ViewModel.DisplayedMobile] = []
    for mobile in response.mobiles {
        //print(mobile)
        let name = mobile.mobile.name
        let description = mobile.mobile.description
        let price = mobile.mobile.price
        let rating = mobile.mobile.rating
        let thumbImageURL = mobile.mobile.thumbImageURL
        let isFav = mobile.isFav

        let mobile = All.FetchMobiles.ViewModel.DisplayedMobile(name: name, description: description, price: price, rating: rating, thumbImageURL: thumbImageURL, isFav: isFav)
        displayedMobiles.append(mobile)
    }
    let viewModel = All.FetchMobiles.ViewModel(displayedMobiles: displayedMobiles)
    print(viewModel)
    viewController?.displayMobiles(viewModel: viewModel)
  }
}
