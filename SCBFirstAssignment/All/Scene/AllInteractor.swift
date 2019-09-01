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
  var mobiles: [Mobile]? { get }
}

class AllInteractor: AllInteractorInterface {
    var mobiles: [Mobile]?
  var presenter: AllPresenterInterface!
  var worker: MobilesWorker?


    func loadContent(request: All.FetchMobiles.Request) {
    print("EI")
    worker?.fetchMobiles { response in
        //print(response)
        self.mobiles = response
        
        let response = All.FetchMobiles.Response(mobiles: (self.mobiles!))
        self.presenter.presentMobiles(response: response)
        }
      }
}

