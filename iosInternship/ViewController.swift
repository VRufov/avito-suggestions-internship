//
//  ViewController.swift
//  iosInternship
//
//  Created by Вадим Руфов on 4/9/22.
//

import UIKit

final class ViewController: UIViewController {
    private var info: SuggestionsResponseModel?
    
    private var list: [SuggestionsOfferModel] = []
    
    private let closeButton: CloseUIButton = {
        let button = CloseUIButton()
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: K.Labels.hugeTitleSize, weight: .heavy)
        label.numberOfLines = 0
        return label
    }()
    
    private let suggestionsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            SuggestionUICollectionViewCell.self,
            forCellWithReuseIdentifier: "\(SuggestionUICollectionViewCell.self)"
        )
        collectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: K.InsetOffsets.collectionViewDefaultOffset,
            bottom: 0,
            right: K.InsetOffsets.collectionViewDefaultOffset
        )
        return collectionView
    }()
    
    private let applyButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Выбрать"
        configuration.titleAlignment = .center
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: K.Labels.largeTitleSize, weight: .regular)
            return outgoing
        }
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0)
        configuration.background.backgroundColor = K.Colors.blue
        let button = UIButton()
        button.configuration = configuration
        button.layer.cornerRadius = K.Buttons.defaultCornerRadius
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        loadData()
        titleLabel.text = info?.result?.title
        setupView()
        applyButton.addTarget(self, action: #selector(applyButtonPressed), for: .touchUpInside)
    }
    
    private func setupView() {
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(suggestionsCollectionView)
        view.addSubview(applyButton)
        
        suggestionsCollectionView.delegate = self
        suggestionsCollectionView.dataSource = self
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        suggestionsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            closeButton.topAnchor.constraint(equalTo: margins.topAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            suggestionsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            suggestionsCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            suggestionsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            suggestionsCollectionView.bottomAnchor.constraint(equalTo: applyButton.topAnchor),
            
            applyButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            applyButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            applyButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
        ])
    }
    
    private func loadData() {
        if let data = JSONLoader.loadJSON(fileName: "result") {
            info = data
            list = info?.result?.list ?? []
        }
    }
    
    @objc private func applyButtonPressed() {
        let cell = getSelectedCell()
        let message = cell?.data!.title ?? "Пожалуйста, выберите предложение"
        
        let alert = UIAlertController(title: message, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func getSelectedCell() -> SuggestionUICollectionViewCell? {
        if let indexPath = suggestionsCollectionView.indexPathsForSelectedItems?.first {
            let cell = suggestionsCollectionView.cellForItem(at: indexPath) as! SuggestionUICollectionViewCell
            return cell
        }
        return nil
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = suggestionsCollectionView.dequeueReusableCell(
            withReuseIdentifier: "\(SuggestionUICollectionViewCell.self)",
            for: indexPath
        ) as! SuggestionUICollectionViewCell
        cell.data = list[indexPath.row]
        cell.maxWidth = suggestionsCollectionView.bounds.width - 2 * K.InsetOffsets.collectionViewDefaultOffset
        return cell
    }
}
