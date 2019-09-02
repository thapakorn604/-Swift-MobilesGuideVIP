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
            var favMobiles: [Mobile]
        }

        /// Data struct sent to ViewController
        struct ViewModel {
            struct DisplayedFavourite {
                var id: Int!
                var name: String!
                var description: String!
                var price: String!
                var rating: String!
                var thumbImageURL: String!
            }

            var displayedFavourites: [DisplayedFavourite]
        }
    }

    struct SortFavs {
        struct Request {
            var sortingType: Constants.sortingType
            var contentType: Constants.contentType
        }

        struct Response {
            var sortedFavs: [Mobile]
        }

        struct ViewModel {
            struct DisplayedSortedFav {
                var id: Int!
                var name: String!
                var description: String!
                var price: String!
                var rating: String!
                var thumbImageURL: String!
                var isFav: Bool!
            }

            var displayedSortedFavs: [DisplayedSortedFav]
        }
    }
}
