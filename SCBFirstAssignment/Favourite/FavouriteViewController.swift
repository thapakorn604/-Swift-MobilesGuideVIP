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
    
    var content = [Mobile]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        content = ContentManager.shared.favMobiles
        tableView.reloadData()
    }
    
}

extension FavouriteViewController : UITableViewDataSource {
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

extension FavouriteViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let element = content[indexPath.row]
        
        let sendindId = element.mobile.id
        let sendingDetail = element.mobile.description
        let sendingPrice = element.mobile.price
        let sendingRating = element.mobile.rating
        let sendingName = element.mobile.name
        
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        destination.receivedId = sendindId
        destination.receivedDetail = sendingDetail
        destination.receivedPrice = sendingPrice
        destination.receivedRating = sendingRating
        destination.receivedName = sendingName
        
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cellId = content[indexPath.row].mobile.id
            let index = ContentManager.shared.favMobiles.firstIndex(where: {$0.mobile.id == cellId})
            
            let mobileIndex = ContentManager.shared.allMobiles.firstIndex(where: {$0.mobile.id == cellId})
            
            ContentManager.shared.allMobiles[mobileIndex!].isFav = false
            content.remove(at: indexPath.row)
            ContentManager.shared.favMobiles.remove(at: index!)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
