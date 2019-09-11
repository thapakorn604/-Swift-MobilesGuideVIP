import Foundation

class MobilesStore: MobilesProtocol {
  func fetchImages(id: Int, _ completion: @escaping (Result<ImageResponse, Error>) -> Void) {
    let imageUrl = Constants.UrlType.images
    let url = String(format: imageUrl, id)
    
    NetworkManager.shared.feedImages(urlString: url) { response in
      switch response {
      case let .success(result):
        completion(.success(result))
      case let .failure(error):
        completion(.failure(error))
      }
    }
  }
  
  func fetchFavourites(_ completion: @escaping ([Mobile]) -> Void) {
    let result = ContentManager.shared.favMobiles
    completion(result)
  }
  
  func fetchMobiles(_ completion: @escaping (Result<[Mobile], Error>) -> Void) {
    ContentManager.shared.loadContent { response in
      switch response {
      case let .success(result):
        completion(.success(result))
      case let .failure(error):
        completion(.failure(error))
      }
    }
  }
}
