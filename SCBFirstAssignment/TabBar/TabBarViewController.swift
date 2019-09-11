import UIKit

class TabBarViewController: UIViewController {
  @IBOutlet var buttons: [UIButton]!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var sortButton: UIBarButtonItem!
  
  weak var allViewController: AllViewController!
  weak var favouriteViewController: FavouriteViewController!
  
  var viewControllers: [UIViewController]!
  var selectedIndex: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewControllers()
    setup()
  }
  
  func setupViewControllers() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    allViewController = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllerConstant.allViewController) as? AllViewController
    
    favouriteViewController = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllerConstant.favViewController) as? FavouriteViewController
    
    viewControllers = [allViewController, favouriteViewController]
  }
  
  @IBAction func didTapTabButton(_ sender: UIButton) {
    let previousIndex = selectedIndex
    selectedIndex = sender.tag
    
    buttons[previousIndex].isSelected = false
    let previousViewController = viewControllers[previousIndex]
    previousViewController.willMove(toParent: nil)
    previousViewController.view.removeFromSuperview()
    previousViewController.removeFromParent()
    
    sender.isSelected = true
    let currentViewController = viewControllers[selectedIndex]
    
    addChild(currentViewController)
    currentViewController.view.frame = contentView.bounds
    contentView.addSubview(currentViewController.view)
    
    currentViewController.didMove(toParent: self)
  }
  
  func setup() {
    buttons[selectedIndex].isSelected = true
    let initialViewController = viewControllers[selectedIndex]
    addChild(initialViewController)
    initialViewController.view.frame = contentView.bounds
    contentView.addSubview(initialViewController.view)
  }
  
  @IBAction func didTapSort(_ sender: Any) {
    let alert = UIAlertController(title: Constants.SortText.header, message: Constants.emptyString, preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: Constants.SortText.ascending, style: .default, handler: {
      (_: UIAlertAction!) in
      self.sortByPriceAscending()
    }))
    
    alert.addAction(UIAlertAction(title: Constants.SortText.descending, style: .default, handler: {
      (_: UIAlertAction!) in
      self.sortByPriceDescending()
    }))
    
    alert.addAction(UIAlertAction(title: Constants.SortText.rating, style: .default, handler: {
      (_: UIAlertAction!) in
      self.sortByRating()
    }))
    alert.addAction(UIAlertAction(title: Constants.SortText.cancel, style: .cancel, handler: nil))
    
    present(alert, animated: true)
  }
  
  func sortByPriceAscending() {
    if selectedIndex == 0 {
      allViewController.sortMobiles(sortingType: .priceAscending)
    } else {
      favouriteViewController.sortFavourites(sortingType: .priceAscending)
    }
  }
  
  func sortByPriceDescending() {
    if selectedIndex == 0 {
      allViewController.sortMobiles(sortingType: .priceDescending)
    } else {
      favouriteViewController.sortFavourites(sortingType: .priceDescending)
    }
  }
  
  func sortByRating() {
    if selectedIndex == 0 {
      allViewController.sortMobiles(sortingType: .rating)
    } else {
      favouriteViewController.sortFavourites(sortingType: .rating)
    }
  }
}
