import UIKit
import SkeletonView

protocol MobileCellDelegate: class {
  func didSelectFav(cell: MobileCell)
}

class MobileCell: UITableViewCell {

  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var favouriteButton: UIButton!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  
  weak var delegate: MobileCellDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    isUserInteractionEnabled = false
    showSkeleton()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func showSkeleton() {
    [nameLabel, descriptionLabel, priceLabel, ratingLabel].forEach({ $0?.showAnimatedGradientSkeleton() })
    favouriteButton.showAnimatedGradientSkeleton()
    thumbnailImageView.showAnimatedGradientSkeleton()
  }
  
  func hideSkeleton() {
    [nameLabel, descriptionLabel, priceLabel, ratingLabel].forEach({ $0?.hideSkeleton() })
    favouriteButton.hideSkeleton()
    thumbnailImageView.hideSkeleton()
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
