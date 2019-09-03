//
//  DetailRouter.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol DetailRouterInput {
  func navigateToSomewhere()
}

class DetailRouter: DetailRouterInput {
  weak var viewController: DetailViewController!
  
  // MARK: - Navigation
  
  func navigateToSomewhere() {
  }
  
  // MARK: - Communication
  
  func passDataToNextScene(segue: UIStoryboardSegue) {
    // NOTE: Teach the router which scenes it can communicate with
    
    if segue.identifier == "ShowSomewhereScene" {
      passDataToSomewhereScene(segue: segue)
    }
  }
  
  func passDataToSomewhereScene(segue: UIStoryboardSegue) {
  }
}
