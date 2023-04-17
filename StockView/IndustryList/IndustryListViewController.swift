//
//  IndustryListViewController.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import SnapKit
import UIKit

final class IndustryListViewController: UIViewController {

    private let viewModel: IndustryListViewModel
    
    init(viewModel: IndustryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - IndustryListViewModelDelegate

extension IndustryListViewController: IndustryListViewModelDelegate {
    
    func didFetchIndustryList() {}
}
