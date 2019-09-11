protocol AllRouterInput {
  func navigateToDetail(mobileId: Int)
}

class AllRouter: AllRouterInput {
  weak var viewController: AllViewController!
  
  func navigateToDetail(mobileId: Int) {
    let destination = viewController.storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllerConstant.detailViewController) as! DetailViewController
    
    destination.receivedId = mobileId
    
    viewController.navigationController?.pushViewController(destination, animated: true)
  }
}
