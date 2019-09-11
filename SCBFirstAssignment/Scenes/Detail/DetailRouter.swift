protocol DetailRouterInput {
  func navigateToSomewhere()
}

class DetailRouter: DetailRouterInput {
  weak var viewController: DetailViewController!

  func navigateToSomewhere() {
  }
}
