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
    func sortMobiles(sortingType: Constants.sortingType, stage: Int)
}

class AllViewController: UIViewController, AllViewControllerInterface {
    var interactor: AllInteractorInterface!
    var router: AllRouter!

    @IBOutlet var tableView: UITableView!

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
        // self.tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("Hello world")
        loadContent()
    }

    // MARK: - Event handling

    func loadContent() {
        let request = All.FetchMobiles.Request()
        let isInternetEnabled = NetworkManager.shared.isReachingInternet()

        if isInternetEnabled {
            interactor.loadContent(request: request)

        } else {
            let alert = UIAlertController(title: "No internet connection", message: "Please connect your device to the internet and try again.", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: {
                (_: UIAlertAction!) in
                self.loadContent()
            }))
            present(alert, animated: true)
        }
    }

    // MARK: - Display logic

    func displayMobiles(viewModel: All.FetchMobiles.ViewModel) {
        displayedMobiles = viewModel.displayedMobiles
        tableView.reloadData()
    }

    func sortMobiles(sortingType: Constants.sortingType, stage: Int) {
        interactor.sortContent(sortingType: sortingType, stage: stage)
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

extension AllViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedMobiles.count == 0 ? 5 : displayedMobiles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellConstant.allTableCell) as? AllTableCell
        cell?.delegate = self

        var element = All.FetchMobiles.ViewModel.DisplayedMobile()

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
//        let element = displayedMobiles[indexPath.row]
//
//        let sendingId = element.id
//        let sendingDescription = element.description
//        let sendingPrice = element.price
//        let sendingRating = element.rating
//        let sendingName = element.name
//
//        router.navigateToDetail(id: sendingId, name: sendingName, description: sendingDescription, price: sendingPrice, rating: sendingRating)
    }
}

extension AllViewController: AllTableCellDelegate {
    func didSelectFav(cell: AllTableCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            return
        }

        print("Button tapped on row \(indexPath.row)")

        let cellId = displayedMobiles[indexPath.row].id
        let index = ContentManager.shared.allMobiles.firstIndex(where: { $0.mobile.id == cellId })
        let favIndex = ContentManager.shared.favMobiles.firstIndex(where: { $0.mobile.id == cellId })

        var element = ContentManager.shared.allMobiles[index!]

        if !element.isFav {
            element.isFav = true
            ContentManager.shared.favMobiles.append(element)
            ContentManager.shared.allMobiles[index!].isFav = true
        } else {
            element.isFav = false
            ContentManager.shared.favMobiles.remove(at: favIndex!)
            ContentManager.shared.allMobiles[index!].isFav = false
        }
    }
}
