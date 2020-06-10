protocol AllInteractorInterface {
  func loadContent(request: All.FetchMobiles.Request)
  func sortContent(request: All.SortMobiles.Request)
  func updateFavourite(request: All.UpdateFavourite.Request)
  var mobiles: [Mobile] { get set }
}

class AllInteractor: AllInteractorInterface {
  var mobiles: [Mobile] = []
  var presenter: AllPresenterInterface!
  var worker: MobilesWorker?

  func loadContent(request: All.FetchMobiles.Request) {
    worker?.fetchMobiles { [weak self] response in

      switch response {
      case let .success(result):
        self?.mobiles = result
        let content: Content<[Mobile]> = .success(data: result)
        let response = All.FetchMobiles.Response(content: content)
        self?.presenter.presentMobiles(response: response)
      case let .failure(error):
        let content: Content<[Mobile]> = .error(error.localizedDescription)
        let response = All.FetchMobiles.Response(content: content)
        self?.presenter.presentMobiles(response: response)
      }
    }
  }

  func sortContent(request: All.SortMobiles.Request) {
    switch request.sortingType {
    case .priceDescending:
      mobiles = sortByPriceDescending(mobiles)
      ContentManager.shared.allMobiles = mobiles
    case .priceAscending:
      mobiles = sortByPriceAscending(mobiles)
      ContentManager.shared.allMobiles = mobiles
    case .rating:
      mobiles = sortByRating(mobiles)
      ContentManager.shared.allMobiles = mobiles
    }
    let content: Content<[Mobile]> = .success(data: mobiles)
    let response = All.FetchMobiles.Response(content: content)
    presenter.presentMobiles(response: response)
  }

  func sortByPriceAscending(_ list: [Mobile]) -> [Mobile] {
    return list.sorted { $0.mobile.price < $1.mobile.price }
  }

  func sortByPriceDescending(_ list: [Mobile]) -> [Mobile] {
    return list.sorted { $0.mobile.price > $1.mobile.price }
  }

  func sortByRating(_ list: [Mobile]) -> [Mobile] {
    return list.sorted { $0.mobile.rating > $1.mobile.rating }
  }

  func updateFavourite(request: All.UpdateFavourite.Request) {
    guard let index = mobiles.firstIndex(where: { $0.mobile.id == request.id }) else { return }
    let element = mobiles[index]

    if !element.isFav {
      mobiles[index].isFav = true
      ContentManager.shared.favMobiles.append(element)
    } else {
      mobiles[index].isFav = false
      if let favIndex = ContentManager.shared.favMobiles.firstIndex(where: { $0.mobile.id == request.id }) {
        ContentManager.shared.favMobiles.remove(at: favIndex)
      }
    }

    ContentManager.shared.allMobiles = mobiles

    let content: Content<[Mobile]> = .success(data: mobiles)
    let response = All.FetchMobiles.Response(content: content)
    presenter.presentMobiles(response: response)
  }
}
