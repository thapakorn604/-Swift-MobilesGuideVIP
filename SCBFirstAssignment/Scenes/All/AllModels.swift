//
//  AllModels.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

struct All {
  /// This structure represents a use case
  struct FetchMobiles {
    /// Data struct sent to Interactor
    struct Request {
    }
    
    /// Data struct sent to Presenter
    struct Response {
      let content: Content<[Mobile]>
    }
    
    /// Data struct sent to ViewController
    struct ViewModel {
      struct DisplayedMobile {
        let id: Int!
        let name: String!
        let description: String!
        let price: String!
        let rating: String!
        let thumbImageURL: String!
        let isFav: Bool!
      }
      let displayedMobiles: Content<[DisplayedMobile]>
    }
  }
  
  struct SortMobiles {
    struct Request {
      let sortingType : Constants.sortingType
      let contentType : Constants.contentType
    }
    
    struct Response {
      let sortedMobiles: [Mobile]
    }
  }
  
  struct UpdateFavourite {
    struct Request {
      let id : Int
    }
    struct Response {
      
    }
  }
}
