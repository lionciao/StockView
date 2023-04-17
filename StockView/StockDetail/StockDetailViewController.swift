//
//  StockDetailViewController.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import SnapKit
import UIKit

final class StockDetailViewController: UIViewController {
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var seperatorView = makeSeperatorView()
    private lazy var favoritesButton = makeFavoritesButton()
    
    private lazy var containerScrollView = makeScrollContainerView()
    private lazy var containerStackView = makeContainerStackView()
    private lazy var nameTitleLabel = makeSubtitleLabel(title: "基本資料")
    private lazy var nameValueLabel = makeValueLabel()
    private lazy var chairmanTitleLabel = makeSubtitleLabel(title: "董事長")
    private lazy var chairmanValueLabel = makeValueLabel()
    private lazy var gmTitleLabel = makeSubtitleLabel(title: "總經理")
    private lazy var gmValueLabel = makeValueLabel()
    private lazy var industryTitleLabel = makeSubtitleLabel(title: "產業類別")
    private lazy var industryValueLabel = makeValueLabel()
    private lazy var startedTitleLabel = makeSubtitleLabel(title: "公司成立日期")
    private lazy var startedValueLabel = makeValueLabel()
    private lazy var listedTitleLabel = makeSubtitleLabel(title: "上市日期")
    private lazy var listedValueLabel = makeValueLabel()
    private lazy var telTitleLabel = makeSubtitleLabel(title: "總機")
    private lazy var telValueLabel = makeValueLabel()
    private lazy var taxIDTitleLabel = makeSubtitleLabel(title: "統一編號")
    private lazy var taxIDValueLabel = makeValueLabel()
    private lazy var addressTitleLabel = makeSubtitleLabel(title: "地址")
    private lazy var addressValueLabel = makeValueLabel()
    private lazy var capitalTitleLabel = makeSubtitleLabel(title: "實收資本額 (元)")
    private lazy var capitalValueLabel = makeValueLabel()
    private lazy var sharePriceTitleLabel = makeSubtitleLabel(title: "普通股每股面額")
    private lazy var sharePriceValueLabel = makeValueLabel()
    private lazy var issuedShareTitleLabel = makeSubtitleLabel(title: "已發行普通股數或 TDR 原發行股數")
    private lazy var issuedSharePriceValueLabel = makeValueLabel()
    private lazy var preferredStockTitleLabel = makeSubtitleLabel(title: "特別股")
    private lazy var preferredStockValueLabel = makeValueLabel()
    
    private let viewModel: StockDetailViewModel
    
    init(viewModel: StockDetailViewModel) {
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
        config(with: viewModel.stock)
        addObservers()
    }
    
    deinit {
        removeObservers()
    }
}

// MARK: - Config

extension StockDetailViewController {

    func config(with model: StockModel) {
        favoritesButton.isSelected = viewModel.isFavorites()
        nameValueLabel.text = model.name
        industryValueLabel.text = model.industryID.name
        chairmanValueLabel.text  = model.chairman
        gmValueLabel.text  = model.generalManager
        startedValueLabel.text = model.started
        listedValueLabel.text = model.listed
        telValueLabel.text = model.telephoneNumber
        taxIDValueLabel.text = model.taxIDNumber
        addressValueLabel.text = model.address
        capitalValueLabel.text = model.contributedCapitalText
        sharePriceValueLabel.text = model.parValuePerShareOfCommonStockText
        issuedSharePriceValueLabel.text = model.issuedShareText
        preferredStockValueLabel.text = model.preferredStockText
    }
}

// MARK: - Selectors

private extension StockDetailViewController {
    
    @objc func favoritesButtonPress(_ sender: UIButton) {
        let alertContent = viewModel.alertContent()
        let alert = UIAlertController(
            title: alertContent.title,
            message: alertContent.content,
            preferredStyle: .alert
        )
        let mainAction = UIAlertAction(title: alertContent.doButtonText, style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.doFavoritesAction()
        }
        let cancelAction = UIAlertAction(title: alertContent.cancelButtonText, style: .cancel)
        alert.addAction(mainAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Helpers

private extension StockDetailViewController {
    
    @objc func reloadFavoritesStatus() {
        favoritesButton.isSelected = viewModel.isFavorites()
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFavoritesStatus), name: .favoritesStatusDidChange, object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: .favoritesStatusDidChange, object: nil)
    }
}

// MARK: - View makers

private extension StockDetailViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        containerScrollView.backgroundColor = .white
        titleLabel.text = viewModel.title
        navigationController?.navigationBar.isHidden = false
        navigationItem.setRightBarButton(UIBarButtonItem(customView: favoritesButton), animated: true)
        
        [titleLabel, seperatorView, containerScrollView].forEach {
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
        
        containerScrollView.snp.makeConstraints { make in
            make.top.equalTo(seperatorView.snp.bottom).offset(14)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        containerScrollView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
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
    
    func makeScrollContainerView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }
    
    func makeContainerStackView() -> UIStackView {
        let stackView = UIStackView(
            arrangedSubviews: [
                makeInfoVerticalStackView(views: [nameTitleLabel, nameValueLabel]),
                makeInfoHorizontalStackView(views: [
                    makeInfoVerticalStackView(views: [chairmanTitleLabel, chairmanValueLabel]),
                    makeInfoVerticalStackView(views: [gmTitleLabel, gmValueLabel]),
                    makeInfoVerticalStackView(views: [industryTitleLabel, industryValueLabel])
                ]),
                makeInfoHorizontalStackView(views: [
                    makeInfoVerticalStackView(views: [startedTitleLabel, startedValueLabel]),
                    makeInfoVerticalStackView(views: [listedTitleLabel, listedValueLabel])
                ]),
                makeSubseperatorView(),
                makeInfoHorizontalStackView(views: [
                    makeInfoVerticalStackView(views: [telTitleLabel, telValueLabel]),
                    makeInfoVerticalStackView(views: [taxIDTitleLabel, taxIDValueLabel])
                ]),
                makeInfoVerticalStackView(views: [addressTitleLabel, addressValueLabel]),
                makeSubseperatorView(),
                makeInfoVerticalStackView(views: [capitalTitleLabel, capitalValueLabel]),
                makeInfoVerticalStackView(views: [sharePriceTitleLabel, sharePriceValueLabel]),
                makeInfoVerticalStackView(views: [issuedShareTitleLabel, issuedSharePriceValueLabel]),
                makeInfoVerticalStackView(views: [preferredStockTitleLabel, preferredStockValueLabel])
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }
    
    func makeInfoHorizontalStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }
    
    func makeInfoVerticalStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }
    
    func makeSubtitleLabel(title: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.text = title
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }
    
    func makeValueLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }
    
    func makeSubseperatorView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return view
    }
    
    func makeFavoritesButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named:"star_empty"), for: .normal)
        button.setImage(UIImage(named: "star_filled"), for: .selected)
        button.addTarget(self, action: #selector(favoritesButtonPress(_:)), for: .touchUpInside)
        return button
    }
}
