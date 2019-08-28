//
//  TabBarViewController.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController {
    
    @IBOutlet var buttons : [UIButton]!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    var allViewController : AllViewController!
    var favouriteViewController : FavouriteViewController!
    
    var viewControllers : [UIViewController]!
    
    var selectedIndex : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        setup()
        
    }
    
    func setupViewControllers() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        allViewController = storyboard.instantiateViewController(withIdentifier: "AllViewController") as? AllViewController
        
        favouriteViewController = storyboard.instantiateViewController(withIdentifier: "FavouriteViewController") as? FavouriteViewController
        
        viewControllers = [allViewController, favouriteViewController]
    }
    
    
    @IBAction func didTapTabButton(_ sender: UIButton) {
        //save prev index and get current index
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        //remove prev VC
        buttons[previousIndex].isSelected = false
        let previousViewController = viewControllers[previousIndex]
        previousViewController.willMove(toParent: nil)
        previousViewController.view.removeFromSuperview()
        previousViewController.removeFromParent()
        
        //get current VC
        sender.isSelected = true
        let currentViewController = viewControllers[selectedIndex]
        
        //add current VC
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
        let alert = UIAlertController(title: "Sort", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Price low to high", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Price high to low", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Rating", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
}
