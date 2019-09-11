import Alamofire
import Foundation
import Network

protocol MobilesProtocol {
  func fetchMobiles(_ completion: @escaping (Result<[Mobile], Error>) -> Void)
  func fetchFavourites(_ completion: @escaping ([Mobile]) -> Void)
  func fetchImages(id: Int, _ completion: @escaping (Result<ImageResponse, Error>) -> Void)
}

class MobilesWorker {
  var store: MobilesProtocol
  init(store: MobilesProtocol) {
    self.store = store
  }
  
  func fetchMobiles(_ completion: @escaping (Result<[Mobile], Error>) -> Void) {
    store.fetchMobiles(completion)
  }
  
  func fetchFavourites(_ completion: @escaping ([Mobile]) -> Void) {
    store.fetchFavourites(completion)
  }
  
  func fetchImages(id: Int, _ completion: @escaping (Result<ImageResponse, Error>) -> Void) {
    store.fetchImages(id: id, completion)
  }
}
