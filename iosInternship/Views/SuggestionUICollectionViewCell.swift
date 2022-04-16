//
//  SuggestionUICollectionViewCell.swift
//  iosInternship
//
//  Created by Вадим Руфов on 4/11/22.
//

import UIKit

class SuggestionUICollectionViewCell: UICollectionViewCell {
    static let identifier = "AdRateCollectionViewCell"
    var maxWidth: CGFloat = 0 {
        didSet {
            // Small hack to disable automatic width resizing
            NSLayoutConstraint.activate([
                contentView.widthAnchor.constraint(equalToConstant: maxWidth)
            ])
        }
    }
    
    override var isSelected: Bool {
        didSet {
            isSelected ? setIsSelected() : setIsDeselected()
        }
    }

    var data: SuggectionsOfferModel? {
        didSet {
            titleLabel.text = data!.title
            descriptionLabel.text = data?.description
            priceLabel.text = data!.price
            icon.setImageFromServerURL(urlString: data!.icon.imageURL)
        }
    }
    
    private var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: K.Labels.largeTitleSize, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: K.Labels.mediumTitleSize, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: K.Labels.mediumTitleSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stack: UIView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let isSelectedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFill
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        imageView.image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: imageConfig)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        applyConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(icon)
        contentView.addSubview(stack)
        contentView.addSubview(isSelectedIcon)
        
        stack.addSubview(titleLabel)
        stack.addSubview(descriptionLabel)
        stack.addSubview(priceLabel)
    }
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            icon.widthAnchor.constraint(equalToConstant: 52),
            icon.heightAnchor.constraint(equalToConstant: 52),
            
            stack.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            
            isSelectedIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            isSelectedIcon.leadingAnchor.constraint(equalTo: stack.trailingAnchor),
            isSelectedIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            
            contentView.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = K.Colors.gray
        layer.cornerRadius = K.Layers.defaultLayerRadius
    }
    
    func setIsSelected() {
        isSelectedIcon.isHidden = !isSelectedIcon.isHidden
    }
    
    func setIsDeselected() {
        isSelectedIcon.isHidden = true
    }
}
