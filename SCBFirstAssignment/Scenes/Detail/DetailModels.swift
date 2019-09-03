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
        var id : Int
    }
    /// Data struct sent to Presenter
    struct Response {
        var detailedMobile : Mobile
    }
    /// Data struct sent to ViewController
    struct ViewModel {
        var id: Int!
        var name: String!
        var description: String!
        var price: String!
        var rating: String!
    }
  }
    struct DetailImage {
        struct Request {
            var id : Int
        }
        struct Response {
            var images : ImageResponse
        }
        
        struct ViewModel {
            struct displayedImage {
                var imageURL : String
            }
            var displayedImages : [displayedImage]
            
        }
    }
}
