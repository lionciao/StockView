//
//  IndustryTableCell.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import SnapKit
import UIKit

final class IndustryTableCell: UITableViewCell {
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var arrowImageView = makeArrowImageView()
    private lazy var seperatorView = makeSeperatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - External setups

extension IndustryTableCell {

    func config(with text: String) {
        titleLabel.text = text
    }
}

// MARK: - View makers

private extension IndustryTableCell {
    
    func setupUI() {
        backgroundColor = .white
        selectionStyle = .none
        [titleLabel, arrowImageView, seperatorView].forEach {
            contentView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(14)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(14)
            make.trailing.equalToSuperview().inset(14)
            make.width.height.equalTo(20)
        }
        
        seperatorView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }
    
    func makeArrowImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic-arrow-right")
        return imageView
    }
    
    func makeSeperatorView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return view
    }
}
