//
//  IndustryListViewController.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import SnapKit
import UIKit

final class IndustryListViewController: UIViewController {
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var seperatorView = makeSeperatorView()
    private lazy var tableView = makeTableView()

    private let viewModel: IndustryListViewModel
    
    init(viewModel: IndustryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
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

// MARK: - IndustryListViewModelDelegate

extension IndustryListViewController: IndustryListViewModelDelegate {
    
    func didFetchIndustryList() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
 
extension IndustryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.industyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IndustryTableCell.className, for: indexPath)
        guard
            let collectionCell = cell as? IndustryTableCell,
            !viewModel.shouldShowEmptyView
        else {
            return cell
        }
        let model = viewModel.industyList[indexPath.row]
        let text = "\(model.id.name)(\(model.numberOfCompanies))"
        collectionCell.config(with: text)
        return collectionCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - UITableViewDelegate

extension IndustryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = CompanyListViewModel(
            listRepository: viewModel.listRepository,
            favoritesRepositoy: viewModel.favoritesRepository,
            industryID: viewModel.industryID(at: indexPath.row)
        )
        let vc = CompanyListViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - View makers

private extension IndustryListViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
         
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
        label.text = "產業別"
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
