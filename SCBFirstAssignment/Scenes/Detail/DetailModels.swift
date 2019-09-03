//
//  DetailModels.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

struct Detail {
  /// This structure represents a use case
  struct MobileDetail {
    /// Data struct sent to Interactor
    struct Request {
      let id : Int
    }
    /// Data struct sent to Presenter
    struct Response {
      let detailedMobile : Mobile
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      let id: Int!
      let name: String!
      let description: String!
      let price: String!
      let rating: String!
    }
  }
  struct DetailImage {
    struct Request {
      let id : Int
    }
    struct Response {
      let images : ImageResponse
    }
    
    struct ViewModel {
      struct displayedImage {
        let imageURL : String
      }
      let displayedImages : [displayedImage]
    }
  }
}
