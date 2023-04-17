//
//  CompanyListViewController.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import SnapKit
import UIKit

final class CompanyListViewController: UIViewController {
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var seperatorView = makeSeperatorView()
    private lazy var tableView = makeTableView()

    private let viewModel: CompanyListViewModel
    
    init(viewModel: CompanyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UITableViewDataSource
 
extension CompanyListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.companyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IndustryTableCell.className, for: indexPath)
        guard
            let collectionCell = cell as? IndustryTableCell,
            !viewModel.shouldShowEmptyView
        else {
            return cell
        }
        let model = viewModel.companyList[indexPath.row]
        let text = "\(model.symbol) \(model.nickname)"
        collectionCell.config(with: text)
        return collectionCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - UITableViewDelegate

extension CompanyListViewController: UITableViewDelegate {
}

// MARK: - View makers

private extension CompanyListViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        titleLabel.text = viewModel.title
        navigationController?.navigationBar.isHidden = false

        [titleLabel, seperatorView, tableView].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(14)
        }
        
        seperatorView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(seperatorView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }
    
    func makeSeperatorView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return view
    }
    
    func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(IndustryTableCell.self, forCellReuseIdentifier: IndustryTableCell.className)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.contentInset.top = 10
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }
}
