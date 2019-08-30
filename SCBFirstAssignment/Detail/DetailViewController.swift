//
//  DetailViewController.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 28/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var receivedId : Int!
    var receivedName : String!
    var receivedDetail : String!
    var receivedPrice : Double!
    var receivedRating : Double!
    
    var images = [PurpleImageResponse]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        loadImages()
        setup()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellConstant.imageCollectionCell, for: indexPath) as? ImageCollectionCell
        
        let element = images[indexPath.row]
        let imageUrl = element.url
        
        if NetworkManager.shared.canOpenURL(imageUrl) {
            cell?.detailImageView.loadImageUrl(imageUrl, "mobile")
        } else {
            cell?.detailImageView.loadImageUrl("https://\(imageUrl)", "mobile")
        }
        
        return cell!
    }

    func setup() {
        
        navigationItem.title = receivedName
        detailTextView.text = receivedDetail
        ratingLabel.text = "Rating: \(receivedRating!)"
        priceLabel.text = "Price: \(receivedPrice!)"
        
    }
    
    func loadImages() {
        NetworkManager.shared.feedImages(url: "https://scb-test-mobile.herokuapp.com/api/mobiles/\(receivedId!)/images/") { (result) in
            self.images = result
            self.collectionView.reloadData()
        }
    }
}
