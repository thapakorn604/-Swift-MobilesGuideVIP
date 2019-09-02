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
    func sortContent(request: All.SortMobiles.Request)
    var mobiles: [Mobile] { get set }
}

class AllInteractor: AllInteractorInterface {
    
    var mobiles: [Mobile] = []
    var presenter: AllPresenterInterface!
    var worker: MobilesWorker?

    func loadContent(request: All.FetchMobiles.Request) {
        worker?.fetchMobiles { [weak self] response in
            
            switch response {
            case .success(let result):
                self?.mobiles = result
                
                let response = All.FetchMobiles.Response(mobiles: self!.mobiles)
                self?.presenter.presentMobiles(response: response)
            case .failure(let error):
                print(error)
            }

        }
    }

    func sortContent(request: All.SortMobiles.Request) {
        
            self.mobiles = ContentManager.shared.sortContent(by: request.sortingType, contentType: request.contentType)

            let response = All.FetchMobiles.Response(mobiles: self.mobiles)
            self.presenter.presentMobiles(response: response)
    }
}
