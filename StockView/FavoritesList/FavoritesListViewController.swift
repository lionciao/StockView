//
//  FavoritesListViewController.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import SnapKit
import UIKit

final class FavoritesListViewController: UIViewController {
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var seperatorView = makeSeperatorView()
    private lazy var tableView = makeTableView()

    private let viewModel: FavoritesListViewModel
    
    init(viewModel: FavoritesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addObservers()
    }
    
    deinit {
        removeObservers()
    }
}

// MARK: - FavoritesListViewModelDelegate
 
extension FavoritesListViewController: FavoritesListViewModelDelegate {
    
    func didFetchCompanyList() {
        reloadView()
    }
}

// MARK: - UITableViewDataSource
 
extension FavoritesListViewController: UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertContent = viewModel.alertContent(at: indexPath.row)
            let alert = UIAlertController(
                title: alertContent.title,
                message: alertContent.content,
                preferredStyle: .alert
            )
            let mainAction = UIAlertAction(title: alertContent.doButtonText, style: .default) { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.doFavoritesAction(at: indexPath.row)
            }
            let cancelAction = UIAlertAction(title: alertContent.cancelButtonText, style: .cancel)
            alert.addAction(mainAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDelegate

extension FavoritesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let stock = viewModel.stock(at: indexPath.row) else { return }
        let vm = StockDetailViewModel(
            stock: stock,
            favoritesRepositoy: viewModel.favoritesRepository
        )
        let vc = StockDetailViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Helpers

private extension FavoritesListViewController {
    
    @objc func reloadView() {
        tableView.reloadData()
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: .favoritesStatusDidChange, object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: .favoritesStatusDidChange, object: nil)
    }
}

// MARK: - View makers

private extension FavoritesListViewController {
    
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
