import Foundation

class MobilesMockStore: MobilesProtocol {
  func fetchMobiles(_ completion: @escaping (Result<[Mobile], Error>) -> Void) {
    let mobiles : [Mobile] = [
      Mobile(mobile: MobileResponse(description: "a", id: 1, price: 1, brand: "a", rating: 1.0, thumbImageURL: "a", name: "a"),
             isFav: false),
      Mobile(mobile: MobileResponse(description: "b", id: 2, price: 2, brand: "b", rating: 2.0, thumbImageURL: "b", name: "b"), isFav: false),
      Mobile(mobile: MobileResponse(description: "c", id: 3, price: 3, brand: "c", rating: 3.0, thumbImageURL: "c", name: "c"), isFav: false)
    ]
    
    completion(.success(mobiles))
  }
  
  func fetchFavourites(_ completion: @escaping ([Mobile]) -> Void) {
    let favMobiles : [Mobile] = [
      Mobile(mobile: MobileResponse(description: "a", id: 1, price: 1, brand: "a", rating: 1.0, thumbImageURL: "a", name: "a"),
             isFav: true),
      Mobile(mobile: MobileResponse(description: "b", id: 2, price: 2, brand: "b", rating: 2.0, thumbImageURL: "b", name: "b"), isFav: true),
      Mobile(mobile: MobileResponse(description: "c", id: 3, price: 3, brand: "c", rating: 3.0, thumbImageURL: "c", name: "c"), isFav: true)
    ]
    
    completion(favMobiles)
  }
  
  func fetchImages(id: Int, _ completion: @escaping (Result<ImageResponse, Error>) -> Void) {
    let mockImages : ImageResponse = [
      Image(url: "a", id: 1, mobileID: 1),
      Image(url: "b", id: 2, mobileID: 1),
      Image(url: "c", id: 3, mobileID: 1)]
    
    completion(.success(mockImages))
  }
}

