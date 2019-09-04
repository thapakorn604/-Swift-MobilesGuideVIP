//
//  FavouriteViewController.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol FavouriteViewControllerInterface: class {
  func displayFavourites(viewModel: Favourite.FavMobiles.ViewModel)
  func displayDeletedFavourite(viewModel: Favourite.FavMobiles.ViewModel)
}

class FavouriteViewController: UIViewController, FavouriteViewControllerInterface {
  var interactor: FavouriteInteractorInterface!
  var router: FavouriteRouter!
  
  @IBOutlet weak var tableView: UITableView!
  
  var displayedFavourites: [Favourite.FavMobiles.ViewModel.DisplayedFavourite] = []
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration
  
  private func configure(viewController: FavouriteViewController) {
    let router = FavouriteRouter()
    router.viewController = viewController
    
    let presenter = FavouritePresenter()
    presenter.viewController = viewController
    
    let interactor = FavouriteInteractor()
    interactor.presenter = presenter
    interactor.worker = MobilesWorker(store: MobilesStore())
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(UINib(nibName: Constants.CellConstant.mobileCell, bundle: nil), forCellReuseIdentifier: Constants.CellConstant.mobileCell)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    loadContent()
  }
  
  // MARK: - Event handling
  
  func loadContent() {
    let request = Favourite.FavMobiles.Request()
    interactor.loadContent(request: request)
  }
  
  // MARK: - Display logic
  
  func displayFavourites(viewModel: Favourite.FavMobiles.ViewModel) {
    displayedFavourites = viewModel.displayedFavourites
    tableView.reloadData()
  }
  
  func displayDeletedFavourite(viewModel: Favourite.FavMobiles.ViewModel) {
    displayedFavourites = viewModel.displayedFavourites
  }
  
  func sortFavourites(sortingType: Constants.sortingType) {
    let request = Favourite.SortFavs.Request(sortingType: sortingType)
    interactor.sortContent(request: request)
  }
}

extension FavouriteViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return displayedFavourites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellConstant.mobileCell, for: indexPath) as? MobileCell else {
      return UITableViewCell()
    }
    
    var element : Favourite.FavMobiles.ViewModel.DisplayedFavourite
  
      element = displayedFavourites[indexPath.row]
      cell.isUserInteractionEnabled = true
      cell.hideSkeleton()
      
      cell.nameLabel.text = element.name
      cell.descriptionLabel.text = element.description
      cell.priceLabel.text = element.price
      cell.ratingLabel.text = element.rating
      cell.favouriteButton.isHidden = true
      cell.thumbnailImageView.loadImageUrl(element.thumbImageURL, "mobile")
    return cell
  }
}

extension FavouriteViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let element = displayedFavourites[indexPath.row]
    router.navigateToDetail(mobileId: element.id)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      guard let cellId = displayedFavourites[indexPath.row].id else { return }
      let request = Favourite.DeleteFav.Request(id: cellId)
      interactor.deleteFavourite(request: request)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
}
