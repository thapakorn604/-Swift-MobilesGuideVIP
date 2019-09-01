//
//  AllTableCell.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import SkeletonView
import UIKit

protocol AllTableCellDelegate: class {
    func didSelectFav(cell: AllTableCell)
}

class AllTableCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var favButton: UIButton!
    @IBOutlet var thumbnailImageView: UIImageView!

    weak var delegate: AllTableCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        isUserInteractionEnabled = false
        showSkeleton()
    }

    func showSkeleton() {
        [nameLabel, descriptionLabel, priceLabel, ratingLabel].forEach({ $0?.showAnimatedGradientSkeleton() })
        favButton.showAnimatedGradientSkeleton()
        thumbnailImageView.showAnimatedGradientSkeleton()
    }

    func hideSkeleton() {
        [nameLabel, descriptionLabel, priceLabel, ratingLabel].forEach({ $0?.hideSkeleton() })
        favButton.hideSkeleton()
        thumbnailImageView.hideSkeleton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func didTapFav(_ sender: UIButton) {
        delegate?.didSelectFav(cell: self)
        if !sender.isSelected {
            sender.isSelected = true
        } else {
            sender.isSelected = false
        }
    }
}