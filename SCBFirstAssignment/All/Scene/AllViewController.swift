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
    interactor.worker = MobilesWorker(store: AllStore())

    viewController.interactor = interactor
    viewController.router = router
  }

  // MARK: - View lifecycle
    
    override func viewDidLoad() {
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("Hello world")
        loadContent()
    }

  // MARK: - Event handling
    
    var displayedMobiles: [All.FetchMobiles.ViewModel.DisplayedMobile] = []

  func loadContent() {
    print("Hi")
    let request = All.FetchMobiles.Request()
    interactor.loadContent(request: request)
  }

  // MARK: - Display logic

    func displayMobiles(viewModel: All.FetchMobiles.ViewModel) {
        displayedMobiles = viewModel.displayedMobiles
        print(displayedMobiles)
        self.tableView.reloadData()
    }

  // MARK: - Router

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }

  @IBAction func unwindToAllViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}

extension AllViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedMobiles.count == 0 ? 5 : displayedMobiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellConstant.allTableCell) as? AllTableCell
        //cell?.delegate = self
        
        var element = All.FetchMobiles.ViewModel.DisplayedMobile()
        
        if displayedMobiles.count != 0 {
            cell?.isUserInteractionEnabled = true
            element = displayedMobiles[indexPath.row]
            cell?.hideSkeleton()
            
            cell?.nameLabel.text = element.name
            cell?.descriptionLabel.text = element.description
            cell?.priceLabel.text = "Price: \(element.price)"
            cell?.ratingLabel.text = "Rating: \(element.rating)"
            cell?.favButton.isSelected = element.isFav
            cell?.thumbnailImageView.loadImageUrl(element.thumbImageURL, "mobile")
            
        }
        
        return cell!
    }
}

