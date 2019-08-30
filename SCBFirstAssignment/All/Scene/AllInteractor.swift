//
//  AllInteractor.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 30/8/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AllBusinessLogic
{
  func doSomething(request: All.Something.Request)
}

protocol AllDataStore
{
  //var name: String { get set }
}

class AllInteractor: AllBusinessLogic, AllDataStore
{
  var presenter: AllPresentationLogic?
  var worker: AllWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: All.Something.Request)
  {
    worker = AllWorker()
    worker?.doSomeWork()
    
    let response = All.Something.Response()
    presenter?.presentSomething(response: response)
  }
}