import Foundation
import AlamofireImage

extension UIImageView {
  func loadImageUrl(_ urlString: String, _ placeholder: String) {
    if let url = URL(string: urlString) {
      af_setImage(withURL: url, placeholderImage: UIImage(named: placeholder) )
    }
  }
}
