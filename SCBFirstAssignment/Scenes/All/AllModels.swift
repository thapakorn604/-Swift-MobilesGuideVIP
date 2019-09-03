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
        var id: Int!
        var name: String!
        var description: String!
        var price: String!
        var rating: String!
        var thumbImageURL: String!
        var isFav: Bool!
      }
      let displayedMobiles: Content<[DisplayedMobile]>
    }
  }
  
  struct SortMobiles {
    struct Request {
      var sortingType : Constants.sortingType
      var contentType : Constants.contentType
    }
    
    struct Response {
      var sortedMobiles: [Mobile]
    }
  }
}
