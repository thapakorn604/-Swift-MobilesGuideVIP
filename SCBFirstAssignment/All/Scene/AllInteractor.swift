//
//  AllInteractor.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol AllInteractorInterface {
    func loadContent(request: All.FetchMobiles.Request)
    func sortContent(sortingType: Constants.sortingType, stage: Int)
    var mobiles: [Mobile]? { get }
}

class AllInteractor: AllInteractorInterface {
    var mobiles: [Mobile]?
    var presenter: AllPresenterInterface!
    var worker: MobilesWorker?

    func loadContent(request: All.FetchMobiles.Request) {
        worker?.fetchMobiles { result in
            self.mobiles = result

            let response = All.FetchMobiles.Response(mobiles: self.mobiles!)
            self.presenter.presentMobiles(response: response)
        }
    }

    func sortContent(sortingType: Constants.sortingType, stage: Int) {
        worker?.sortMobiles(sortingType: sortingType, stage: stage, { result in
            self.mobiles = result

            let response = All.FetchMobiles.Response(mobiles: self.mobiles!)
            self.presenter.presentMobiles(response: response)
        })
    }
}
