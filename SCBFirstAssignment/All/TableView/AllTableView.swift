//
//  AllTableViewController.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class AllTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    
    static let shared = AllTableView()


    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allTableCell") as? AllTableCell
        
        //cell?.nameLabel.text = "dasdad"
        
        return cell!
    }
    
}
