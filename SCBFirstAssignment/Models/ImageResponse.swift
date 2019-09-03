//
//  ImageResponse.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 28/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation

typealias ImageResponse = [PurpleImageResponse]

struct PurpleImageResponse: Codable {
  let url: String
  let id, mobileID: Int
  
  enum CodingKeys: String, CodingKey {
    case url, id
    case mobileID = "mobile_id"
  }
}
