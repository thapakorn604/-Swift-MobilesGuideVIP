//
//  AllViewController.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol AllViewControllerInterface: class {
  func displayMobiles(viewModel: All.FetchMobiles.ViewModel)
}

class AllViewController: UIViewController, AllViewControllerInterface {
  
  var interactor: AllInteractorInterface!
  var router: AllRouter!
  
  @IBOutlet weak var tableView: UITableView!
  
  var displayedMobiles: [All.FetchMobiles.ViewModel.DisplayedMobile] = []
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration
  
  private func configure(viewController: AllViewController) {
    let router = AllRouter()
    router.viewController = viewController
    
    let presenter = AllPresenter()
    presenter.viewController = viewController
    
    let interactor = AllInteractor()
    interactor.presenter = presenter
    interactor.worker = MobilesWorker(store: MobilesStore())
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    tableView.dataSource = self
    self.tableView.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    loadContent()
  }
  
  // MARK: - Event handling
  
  func loadContent() {
    let request = All.FetchMobiles.Request()
    interactor.loadContent(request: request)
  }
  
  func showErrorAlert(errorMsg : String) {
    let alert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: {
      (_: UIAlertAction!) in
      self.loadContent()
    }))
    present(alert, animated: true)
  }
  
  // MARK: - Display logic
  
  func displayMobiles(viewModel: All.FetchMobiles.ViewModel) {
    switch viewModel.displayedMobiles {
    case .success(let mobiles):
      displayedMobiles = mobiles
      tableView.reloadData()
    case .error(let error):
      showErrorAlert(errorMsg: error)
    }
  }
  
  func sortMobiles(sortingType: Constants.sortingType) {
    let request = All.SortMobiles.Request(sortingType: sortingType)
    interactor.sortContent(request: request)
  }
}

extension AllViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return displayedMobiles.count == 0 ? 5 : displayedMobiles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellConstant.allTableCell) as? AllTableCell
    cell?.delegate = self
    
    var element : All.FetchMobiles.ViewModel.DisplayedMobile
    
    if displayedMobiles.count != 0 {
      cell?.isUserInteractionEnabled = true
      element = displayedMobiles[indexPath.row]
      cell?.hideSkeleton()
      
      cell?.nameLabel.text = element.name
      cell?.descriptionLabel.text = element.description
      cell?.priceLabel.text = element.price
      cell?.ratingLabel.text = element.rating
      cell?.favButton.isSelected = element.isFav
      cell?.thumbnailImageView.loadImageUrl(element.thumbImageURL, "mobile")
    }
    
    return cell!
  }
}

extension AllViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let element = displayedMobiles[indexPath.row]
    router.navigateToDetail(mobileId: element.id)
  }
}

extension AllViewController: AllTableCellDelegate {
  func didSelectFav(cell: AllTableCell) {
    guard let indexPath = self.tableView.indexPath(for: cell) else { return }
    guard let cellId = displayedMobiles[indexPath.row].id else { return}
    
    let request = All.UpdateFavourite.Request(id: cellId)
    interactor.updateFavourite(request: request)
  }
}
