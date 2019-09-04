//
//  FavTableCell.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 28/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class FavTableCell: UITableViewCell {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var thumbnailImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
