//
//  AllRouter.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol AllRouterInput {
    func navigateToDetail(mobileId: Int)
}

class AllRouter: AllRouterInput {
    weak var viewController: AllViewController!
    
    func navigateToDetail(mobileId: Int) {
        let destination = viewController.storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllerConstant.detailViewController) as! DetailViewController
        
        destination.receivedId = mobileId
        
        viewController.navigationController?.pushViewController(destination, animated: true)
    }
}
