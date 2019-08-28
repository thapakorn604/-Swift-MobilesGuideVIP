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
    
    var content = [Mobile]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupContent()
    }
    
    func setupContent() {
        ContentManager.shared.loadContent(completion: { (result) in
            self.content = result
            self.tableView.reloadData()
        })
    }
    
}

extension AllViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(content)
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allTableCell") as? AllTableCell
        cell?.delegate = self
        
        let element = content[indexPath.row]
        
        //print(element)
        
        cell?.nameLabel.text = element.mobile.name
        cell?.descriptionLabel.text = element.mobile.description
        cell?.priceLabel.text = "Price: \(element.mobile.price)"
        cell?.ratingLabel.text = "Rating: \(element.mobile.rating)"
        cell?.favButton.isSelected = element.isFav
        
        return cell!
    }
}

extension AllViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        self.navigationController?.pushViewController(destination, animated: true)
    }
}

extension AllViewController : AllTableCellDelegate {
    func didSelectFav(cell: AllTableCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        
        //  Do whatever you need to do with the indexPath
        
        print("Button tapped on row \(indexPath.row)")
    }
}
    

