import UIKit

protocol AllViewControllerInterface: class {
  func displayMobiles(viewModel: All.FetchMobiles.ViewModel)
}

class AllViewController: UIViewController, AllViewControllerInterface {
  var interactor: AllInteractorInterface!
  var router: AllRouter!

  @IBOutlet var tableView: UITableView!

  var displayedMobiles: [All.FetchMobiles.ViewModel.DisplayedMobile] = []

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

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

  override func viewDidLoad() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UINib(nibName: Constants.CellConstant.mobileCell, bundle: nil), forCellReuseIdentifier: Constants.CellConstant.mobileCell)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    loadContent()
  }

  func loadContent() {
    let request = All.FetchMobiles.Request()
    interactor.loadContent(request: request)
  }

  func showErrorAlert(errorMsg: String) {
    let alert = UIAlertController(title: Constants.ErrorText.header, message: errorMsg, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: Constants.ErrorText.retry, style: .default, handler: {
      (_: UIAlertAction!) in
      self.loadContent()
    }))
    present(alert, animated: true)
  }

  func displayMobiles(viewModel: All.FetchMobiles.ViewModel) {
    switch viewModel.displayedMobiles {
    case let .success(mobiles):
      displayedMobiles = mobiles
      tableView.reloadData()
    case let .error(error):
      showErrorAlert(errorMsg: error)
    }
  }

  func sortMobiles(sortingType: Constants.SortingType) {
    let request = All.SortMobiles.Request(sortingType: sortingType)
    interactor.sortContent(request: request)
  }
}

extension AllViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return displayedMobiles.count == 0 ? 5 : displayedMobiles.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellConstant.mobileCell, for: indexPath) as? MobileCell else {
      return UITableViewCell()
    }
    cell.delegate = self

    var element: All.FetchMobiles.ViewModel.DisplayedMobile

    if displayedMobiles.count != 0 {
      cell.isUserInteractionEnabled = true
      element = displayedMobiles[indexPath.row]
      cell.hideSkeleton()

      cell.nameLabel.text = element.name
      cell.descriptionLabel.text = element.description
      cell.priceLabel.text = element.price
      cell.ratingLabel.text = element.rating
      cell.favouriteButton.isSelected = element.isFav
      cell.thumbnailImageView.loadImageUrl(element.thumbImageURL, Constants.imagePlaceholder)
    }
    return cell
  }
}

extension AllViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let element = displayedMobiles[indexPath.row]
    router.navigateToDetail(mobileId: element.id)
  }
}

extension AllViewController: MobileCellDelegate {
  func didSelectFav(cell: MobileCell) {
    guard let indexPath = self.tableView.indexPath(for: cell) else { return }
    guard let cellId = displayedMobiles[indexPath.row].id else { return }

    let request = All.UpdateFavourite.Request(id: cellId)
    interactor.updateFavourite(request: request)
  }
}
