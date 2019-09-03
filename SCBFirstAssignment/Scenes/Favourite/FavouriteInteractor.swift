//
//  FavouriteInteractor.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol FavouriteInteractorInterface {
    func loadContent(request: Favourite.FavMobiles.Request)
    func sortContent(request: Favourite.SortFavs.Request)
    var favMobiles: [Mobile] { get }
}

class FavouriteInteractor: FavouriteInteractorInterface {
    var presenter: FavouritePresenterInterface!
    var worker: MobilesWorker?
    var favMobiles: [Mobile] = []

    // MARK: - Business logic

    func loadContent(request: Favourite.FavMobiles.Request) {
        worker?.fetchFavourites { [weak self] result in
            self?.favMobiles = result

            let response = Favourite.FavMobiles.Response(favMobiles: self!.favMobiles)
            self?.presenter.presentFavourites(response: response)
        }
    }

    func sortContent(request: Favourite.SortFavs.Request) {
        favMobiles = ContentManager.shared.sortContent(by: request.sortingType, contentType: request.contentType)

        let response = Favourite.FavMobiles.Response(favMobiles: favMobiles)
        presenter.presentFavourites(response: response)
    }
}
