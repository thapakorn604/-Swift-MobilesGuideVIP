//
//  AllViewController.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class AllViewController2: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    var content = [Mobile]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupContent()
    }
    
    func setupContent() {
        ContentManager.shared.loadContent(completion: { (result) in
            self.content = result
            self.tableView.reloadData()
        })
    }
    
}

extension AllViewController2 : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(content)
        return content.count == 0 ? 5 : content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellConstant.allTableCell) as? AllTableCell
        cell?.delegate = self
        
        var element = Mobile()
        
        if content.count != 0 {
            element = content[indexPath.row]
            cell?.hideSkeleton()
            
            cell?.nameLabel.text = element.mobile.name
            cell?.descriptionLabel.text = element.mobile.description
            cell?.priceLabel.text = "Price: \(element.mobile.price)"
            cell?.ratingLabel.text = "Rating: \(element.mobile.rating)"
            cell?.favButton.isSelected = element.isFav
            cell?.thumbnailImageView.loadImageUrl(element.mobile.thumbImageURL, "mobile")

        }
        
        return cell!
    }
}

extension AllViewController2 : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let element = content[indexPath.row]
        
        let sendingId = element.mobile.id
        let sendingDetail = element.mobile.description
        let sendingPrice = element.mobile.price
        let sendingRating = element.mobile.rating
        let sendingName = element.mobile.name
        
        let destination = self.storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllerConstant.detailViewController) as! DetailViewController2
        
        destination.receivedId = sendingId
        destination.receivedDetail = sendingDetail
        destination.receivedPrice = sendingPrice
        destination.receivedRating = sendingRating
        destination.receivedName = sendingName
        
        self.navigationController?.pushViewController(destination, animated: true)
    }
}

extension AllViewController2 : AllTableCellDelegate {
    func didSelectFav(cell: AllTableCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        
        print("Button tapped on row \(indexPath.row)")
        
        let cellId = content[indexPath.row].mobile.id
        let index = ContentManager.shared.allMobiles.firstIndex(where: {$0.mobile.id == cellId})
        let favIndex = ContentManager.shared.favMobiles.firstIndex(where: {$0.mobile.id == cellId})
        
        var element = ContentManager.shared.allMobiles[index!]
        
        if !element.isFav {
            element.isFav = true
            ContentManager.shared.favMobiles.append(element)
            ContentManager.shared.allMobiles[index!].isFav = true
        } else {
            element.isFav = false
            ContentManager.shared.favMobiles.remove(at: favIndex!)
            ContentManager.shared.allMobiles[index!].isFav = false
        }
    }
}


    

