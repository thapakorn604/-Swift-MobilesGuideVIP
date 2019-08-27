//
//  AllViewController.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class AllViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = AllTableView.shared
        tableView.dataSource = AllTableView.shared

        // Do any additional setup after loading the view.
    }
    
}
