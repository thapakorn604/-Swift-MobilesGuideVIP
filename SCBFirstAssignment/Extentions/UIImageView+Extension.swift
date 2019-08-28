//
//  UIImageView+Extension.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 28/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import AlamofireImage

extension UIImageView {
    func loadImageUrl(_ urlString: String, _ placeholder: String) {
        af_setImage(withURL: URL(string: urlString)!, placeholderImage: UIImage(named: placeholder) )
    }
}
