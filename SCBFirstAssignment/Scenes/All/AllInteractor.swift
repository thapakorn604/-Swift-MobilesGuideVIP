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
        let content: Content<[Mobile]> = .success(data: result)
        let response = All.FetchMobiles.Response(content: content)
        self?.presenter.presentMobiles(response: response)
      case .failure(let error):
        let content: Content<[Mobile]> = .error(error.localizedDescription)
        let response = All.FetchMobiles.Response(content: content)
        self?.presenter.presentMobiles(response: response)
      }
    }
  }
  
  func sortContent(request: All.SortMobiles.Request) {
    
    self.mobiles = ContentManager.shared.sortContent(by: request.sortingType, contentType: request.contentType)
    
    let content : Content<[Mobile]> = .success(data: self.mobiles)
    let response = All.FetchMobiles.Response(content: content)
    self.presenter.presentMobiles(response: response)
  }
}
