//
//  Constant.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 29/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation

class Constants {
  
  static let imagePlaceholder = "mobile"
  static let emptyString = ""
  
  enum  SortingType {
    case priceDescending
    case priceAscending
    case rating
  }
  
  enum ContentType {
    case allMobiles
    case favourites
  }
  
  struct ErrorText {
    static let header = "Error"
    static let retry = "Retry"
  }
  
  struct SortText {
    static let header = "Sort"
    static let ascending = "Price low to high"
    static let descending = "Price high to low"
    static let rating = "Rating"
    static let cancel = "Cancel"
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
