import Alamofire
import Foundation

class NetworkManager {
  static let shared = NetworkManager()
  
  func feedMobiles(urlString: String, completion: @escaping ((Result<[MobileResponse], Error>) -> Void)) {
    
    guard let url = URL(string: urlString) else { return }
    
    AF.request(url, method: .get).response { res in
      switch res.result {
      case .success:
        do {
          let decoder = JSONDecoder()
          let result = try decoder.decode([MobileResponse].self, from: res.data!)
          
          completion(.success(result))
          
        } catch {
          completion(.failure(error))
        }
      case let .failure(error):
        completion(.failure(error))
      }
    }
  }
  
  func feedImages(urlString: String, completion: @escaping ((Result<[Image], Error>) -> Void)) {
    
    guard let url = URL(string: urlString) else { return }
    
    AF.request(url, method: .get).response { res in
      switch res.result {
      case .success:
        do {
          let decoder = JSONDecoder()
          let result = try decoder.decode([Image].self, from: res.data!)
          
          completion(.success(result))
          
        } catch {
          completion(.failure(error))
        }
      case let .failure(error):
        completion(.failure(error))
      }
    }
  }
  
  func canOpenURL(_ string: String?) -> Bool {
    guard let urlString = string,
      let url = URL(string: urlString)
      else { return false }
    
    if !UIApplication.shared.canOpenURL(url) { return false }
    
    let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
    let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regEx])
    return predicate.evaluate(with: string)
  }
}
