//
//  DetailPresenter.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol DetailPresenterInterface {
  func presentDetail(response: Detail.MobileDetail.Response)
  func presentImage(response: Detail.DetailImage.Response)
}

class DetailPresenter: DetailPresenterInterface {
  
  weak var viewController: DetailViewControllerInterface!
  
  func presentDetail(response: Detail.MobileDetail.Response) {
    
    let mobile = response.detailedMobile.mobile!
    
    let id = mobile.id
    let name = mobile.name
    let description = mobile.description
    let price = "Price: \(mobile.price)"
    let rating = "Rating: \(mobile.price)"
    
    let viewModel = Detail.MobileDetail.ViewModel(id: id, name: name, description: description, price: price, rating: rating)
    viewController.displayDetail(viewModel:viewModel)
  }
  
  func presentImage(response: Detail.DetailImage.Response) {
    var displayedImages : [Detail.DetailImage.ViewModel.displayedImage] = []
    
    for image in response.images{
      var imageURL = image.url
      if !NetworkManager.shared.canOpenURL(imageURL) {
        imageURL = "https://\(imageURL)"
      }
      let image = Detail.DetailImage.ViewModel.displayedImage(imageURL: imageURL)
      displayedImages.append(image)
    }
    let viewModel = Detail.DetailImage.ViewModel(displayedImages: displayedImages)
    self.viewController.displayImage(viewModel: viewModel)
    
  }
}
