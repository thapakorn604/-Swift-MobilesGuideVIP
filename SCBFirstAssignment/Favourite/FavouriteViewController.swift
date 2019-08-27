//
//  FavouriteViewController.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = FavouriteTableView.shared
        tableView.dataSource = FavouriteTableView.shared
        
    }
    

}
