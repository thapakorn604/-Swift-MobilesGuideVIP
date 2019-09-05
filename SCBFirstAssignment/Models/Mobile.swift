//
//  Mobile.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 1/9/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation

struct Mobile : Equatable {
  static func == (lhs: Mobile, rhs: Mobile) -> Bool {
    return lhs.mobile == rhs.mobile && lhs.isFav == rhs.isFav
  }
  
  var mobile : PurpleMobileResponse!
  var isFav : Bool!
}
