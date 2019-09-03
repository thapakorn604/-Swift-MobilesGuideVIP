//
//  DetailViewController.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol DetailViewControllerInterface: class {
  func displayDetail(viewModel: Detail.MobileDetail.ViewModel)
  func displayImage(viewModel: Detail.DetailImage.ViewModel)
}

class DetailViewController: UIViewController, DetailViewControllerInterface {
  var interactor: DetailInteractorInterface!
  var router: DetailRouter!
  
  var receivedId: Int!
  
  var detailMobile: Mobile!
  var displayImages: [Detail.DetailImage.ViewModel.displayedImage] = []
  
  @IBOutlet var detailTextView: UITextView!
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var ratingLabel: UILabel!
  @IBOutlet var priceLabel: UILabel!
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration
  
  private func configure(viewController: DetailViewController) {
    let router = DetailRouter()
    router.viewController = viewController
    
    let presenter = DetailPresenter()
    presenter.viewController = viewController
    
    let interactor = DetailInteractor()
    interactor.presenter = presenter
    interactor.worker = MobilesWorker(store: MobilesStore())
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    getDetail()
    getImages()
  }
  
  // MARK: - Event handling
  
  func getDetail() {
    let request = Detail.MobileDetail.Request(id: receivedId)
    interactor.getDetail(request: request)
  }
  
  func getImages() {
    let request = Detail.DetailImage.Request(id: receivedId)
    interactor.getImages(request: request)
  }
  
  func showErrorAlert(errorMsg : String) {
    let alert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: nil))
    present(alert, animated: true)
  }
  
  // MARK: - Display logic
  
  func displayDetail(viewModel: Detail.MobileDetail.ViewModel) {
    navigationItem.title = viewModel.name
    priceLabel.text = viewModel.price
    ratingLabel.text = viewModel.rating
    detailTextView.text = viewModel.description
    
    // nameTextField.text = viewModel.name
  }
  
  func displayImage(viewModel: Detail.DetailImage.ViewModel) {
    switch viewModel.displayedImages {
    case .success(let images):
      displayImages = images
      collectionView.reloadData()
    case .error(let error):
      showErrorAlert(errorMsg: error)
    }
  }
}

extension DetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return displayImages.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellConstant.imageCollectionCell, for: indexPath) as? ImageCollectionCell
    
    let element = displayImages[indexPath.row]
    cell?.detailImageView.loadImageUrl(element.imageURL, "mobile")
    
    return cell!
  }
}
