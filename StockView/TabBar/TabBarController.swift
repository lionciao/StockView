//
//  TabBarController.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private lazy var stockListViewController = makeStockListViewController()
    private lazy var favoritesListViewController = makeFavoritesListViewController()
    
    let viewModel: TabBarViewModel
    
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        viewModel.fetchStockList()
    }
}

// MARK: Helpers

private extension TabBarController {
    
    func layoutUI() {
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .darkGray
        UITabBar.appearance().unselectedItemTintColor = .lightGray
        UITabBar.appearance().isTranslucent = false
        
        viewControllers = [
            stockListViewController,
            favoritesListViewController
        ].map { UINavigationController(rootViewController: $0) }
    }
    
    func makeStockListViewController() -> UIViewController {
        let vc = ViewController()
        vc.tabBarItem = UITabBarItem(
            title: "產業",
            image: UIImage(named:"stock_normal"),
            selectedImage: UIImage(named:"stock_selected")
        )
        return vc
    }
    
    func makeFavoritesListViewController() -> UIViewController {
        let vc = ViewController()
        vc.tabBarItem = UITabBarItem(
            title: "追蹤",
            image: UIImage(named:"star_normal"),
            selectedImage: UIImage(named:"star_selected")
        )
        return vc
    }
}
