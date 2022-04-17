//
//  SuggestionUICollectionViewCell.swift
//  iosInternship
//
//  Created by Вадим Руфов on 4/11/22.
//

import UIKit

class SuggestionUICollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            updateSelectedIcon(with: isSelected)
        }
    }
    
    var maxWidth: CGFloat = 0 {
        didSet {
            // Small hack to disable automatic width resizing
            NSLayoutConstraint.activate([
                contentView.widthAnchor.constraint(equalToConstant: maxWidth)
            ])
        }
    }
    
    var data: SuggestionsOfferModel? {
        didSet {
            titleLabel.text = data?.title
            descriptionLabel.text = data?.description
            priceLabel.text = data?.price
            if let imageURL = data?.icon.imageURL {
                icon.setImageFromServerURL(urlString: imageURL)
            }
        }
    }
    
    private var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: K.Labels.largeTitleSize, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: K.Labels.mediumTitleSize, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: K.Labels.mediumTitleSize, weight: .bold)
        return label
    }()
    
    private let labelsContainer: UIView = {
        let stackView = UIView()
        return stackView
    }()
    
    private let selectedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFill
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        imageView.image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: imageConfig)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        descriptionLabel.text = nil
        priceLabel.text = nil
        icon.image = nil
    }
    
    private func setupView() {
        configureContentView()
        
        contentView.addSubview(icon)
        contentView.addSubview(labelsContainer)
        contentView.addSubview(selectedIcon)
        
        labelsContainer.addSubview(titleLabel)
        labelsContainer.addSubview(descriptionLabel)
        labelsContainer.addSubview(priceLabel)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        labelsContainer.translatesAutoresizingMaskIntoConstraints = false
        selectedIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            icon.widthAnchor.constraint(equalToConstant: 52),
            icon.heightAnchor.constraint(equalToConstant: 52),
            
            labelsContainer.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
            labelsContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            labelsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            labelsContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: labelsContainer.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor),
            
            selectedIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            selectedIcon.leadingAnchor.constraint(equalTo: labelsContainer.trailingAnchor),
            selectedIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            
            contentView.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func configureContentView() {
        contentView.backgroundColor = K.Colors.gray
        contentView.layer.cornerRadius = K.Layers.defaultLayerRadius
    }
    
    private func updateSelectedIcon(with isSelectedState: Bool) {
        selectedIcon.isHidden = !isSelectedState
    }
}
