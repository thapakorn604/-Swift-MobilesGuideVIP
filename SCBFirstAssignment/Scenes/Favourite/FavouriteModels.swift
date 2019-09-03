//
//  FavouriteModels.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

struct Favourite {
  /// This structure represents a use case
  struct FavMobiles {
    /// Data struct sent to Interactor
    struct Request {
    }
    
    /// Data struct sent to Presenter
    struct Response {
      let favMobiles: [Mobile]
    }
    
    /// Data struct sent to ViewController
    struct ViewModel {
      struct DisplayedFavourite {
        let id: Int!
        let name: String!
        let description: String!
        let price: String!
        let rating: String!
        let thumbImageURL: String!
      }
      
      let displayedFavourites: [DisplayedFavourite]
    }
  }
  
  struct SortFavs {
    struct Request {
      let sortingType: Constants.sortingType
    }
    
    struct Response {

    }
  }
  
  struct DeleteFav {
    struct Request {
      let id : Int
    }
    struct Response {
      
    }
  }
}
