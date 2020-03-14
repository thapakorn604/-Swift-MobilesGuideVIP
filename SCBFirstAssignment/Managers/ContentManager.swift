import Foundation
import UIKit

class ContentManager {
  var allMobiles = [Mobile]()
  var favMobiles = [Mobile]()
  
  static let shared = ContentManager()
  
  private init() {
  }
  
  func loadContent(completion: @escaping (Result<[Mobile], Error>) -> Void) {
    if allMobiles.count > 0 {
      completion(.success(self.allMobiles))
      return
    }
    
    NetworkManager.shared.feedMobiles(urlString: Constants.UrlType.mobiles) { [weak self] response in
      switch response {
      case .success(let result):
        var mobiles : [Mobile] = []
        for i in 0 ... result.count - 1 {
          let newMobile = Mobile(mobile: result[i], isFav: false)
          mobiles.append(newMobile)
        }
        self?.allMobiles = mobiles
        completion(.success(mobiles))
        
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
