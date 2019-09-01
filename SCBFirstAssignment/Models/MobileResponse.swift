//
//  MobileResponse.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 28/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation

typealias MobileResponse = [PurpleMobileResponse]

struct PurpleMobileResponse: Codable {
    let description: String
    let id: Int
    let price: Double
    let brand: String
    let rating: Double
    let thumbImageURL, name: String
}
