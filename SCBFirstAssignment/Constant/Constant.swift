//
//  Constant.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 29/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation

class Constants {
    
    enum  sortingType {
        case priceDescending
        case priceAscending
        case rating
    }
    
    enum contentType {
        case allMobiles
        case favourites
    }
    
    struct ViewControllerConstant {
        static let allViewController = "AllViewController"
        static let favViewController = "FavouriteViewController"
        static let detailViewController = "DetailViewController"
    }
    
    struct CellConstant {
        static let allTableCell = "allTableCell"
        static let favTableCell = "favTableCell"
        static let imageCollectionCell = "imageCollectionCell"
    }
    
}
