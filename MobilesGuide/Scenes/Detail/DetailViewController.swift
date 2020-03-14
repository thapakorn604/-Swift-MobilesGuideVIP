import UIKit

protocol DetailViewControllerInterface: class {
  func displayDetail(viewModel: Detail.MobileDetail.ViewModel)
  func displayImage(viewModel: Detail.DetailImage.ViewModel)
}

class DetailViewController: UIViewController, DetailViewControllerInterface {
  var interactor: DetailInteractorInterface!
  var router: DetailRouter!
  
  var receivedId: Int!
  
  var displayImages: [Detail.DetailImage.ViewModel.displayedImage] = []
  
  @IBOutlet weak var detailTextView: UITextView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    getDetail()
    getImages()
  }
  
  func getDetail() {
    let request = Detail.MobileDetail.Request(id: receivedId)
    interactor.getDetail(request: request)
  }
  
  func getImages() {
    let request = Detail.DetailImage.Request(id: receivedId)
    interactor.getImages(request: request)
  }
  
  func showErrorAlert(errorMsg : String) {
    let alert = UIAlertController(title: Constants.ErrorText.header, message: errorMsg, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: Constants.ErrorText.retry, style: .default, handler: nil))
    present(alert, animated: true)
  }
  
  
  func displayDetail(viewModel: Detail.MobileDetail.ViewModel) {
    navigationItem.title = viewModel.name
    priceLabel.text = viewModel.price
    ratingLabel.text = viewModel.rating
    detailTextView.text = viewModel.description
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
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellConstant.imageCollectionCell, for: indexPath) as? ImageCollectionCell else {
      return UICollectionViewCell()
    }
    
    let element = displayImages[indexPath.row]
    cell.detailImageView.loadImageUrl(element.imageURL, Constants.imagePlaceholder)
    
    return cell
  }
}
