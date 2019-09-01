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
        var mobiles : [Mobile]
    }
    /// Data struct sent to ViewController
    struct ViewModel {
        struct DisplayedMobile {
            var name : String!
            var description : String!
            var price : Double!
            var rating : Double!
            var thumbImageURL : String!
            var isFav : Bool!
        }
        var displayedMobiles : [DisplayedMobile]
    }
  }
}
