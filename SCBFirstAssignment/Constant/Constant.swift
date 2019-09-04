//
//  Constant.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 29/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation

class Constants {
  
  enum  sortingType {
    case priceDescending
    case priceAscending
    case rating
  }
  
  enum contentType {
    case allMobiles
    case favourites
  }
  
  struct UrlType {
    static let mobiles = "https://scb-test-mobile.herokuapp.com/api/mobiles/"
    static let images = "https://scb-test-mobile.herokuapp.com/api/mobiles/%d/images/"
  }
  
  struct ViewControllerConstant {
    static let allViewController = "AllViewController"
    static let favViewController = "FavouriteViewController"
    static let detailViewController = "DetailViewController"
  }
  
  struct CellConstant {
    static let mobileCell = "MobileCell"
    static let imageCollectionCell = "imageCollectionCell"
  }
  
}

enum Content<T> {
  case success(data: T)
  case error(String)
}
