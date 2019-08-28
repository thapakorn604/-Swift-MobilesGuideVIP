//
//  FavouriteViewController.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!
    
    var content = [Mobile]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        content = ContentManager.shared.favMobiles
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favTableCell") as? FavTableCell
        
        let element = content[indexPath.row]
        
        //print(element)
        
        cell?.nameLabel.text = element.mobile.name
        cell?.descriptionLabel.text = element.mobile.description
        cell?.priceLabel.text = "Price: \(element.mobile.price)"
        cell?.ratingLabel.text = "Rating: \(element.mobile.rating)"
        cell?.thumbnailImageView.loadImageUrl(element.mobile.thumbImageURL, "mobile")
        
        return cell!
    }
}
