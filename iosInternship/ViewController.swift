//
//  ViewController.swift
//  iosInternship
//
//  Created by Вадим Руфов on 4/9/22.
//

import UIKit

class ViewController: UIViewController {
    private var info: SuggectionsResponseModel?
    private var list: [SuggectionsOfferModel]?

    private let closeButton: CloseUIButton = {
        let button = CloseUIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: K.Labels.hugeTitleSize, weight: .heavy)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let suggestionsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            SuggestionUICollectionViewCell.self,
            forCellWithReuseIdentifier: SuggestionUICollectionViewCell.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let applyButton: UIButton = {
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
        button.addTarget(self, action: #selector(applyButtonPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        
        loadData()
        titleLabel.text = info?.result.title
        addSubviews()
        setDelegates()
        setConstraints()
    }
    
    private func loadData() {
        do {
            let data = try Data(contentsOf: Bundle.main.url(forResource: "result", withExtension: "json")!)
            info = try JSONDecoder().decode(SuggectionsResponseModel.self, from: data)
            list = info?.result.list
            suggestionsCollectionView.reloadData()
        } catch { print(error) }
    }
    
    private func addSubviews() {
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(suggestionsCollectionView)
        view.addSubview(applyButton)
    }
    
    private func setDelegates() {
        suggestionsCollectionView.delegate = self
        suggestionsCollectionView.dataSource = self
    }
    
    private func setConstraints() {
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            closeButton.topAnchor.constraint(equalTo: margins.topAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            suggestionsCollectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            suggestionsCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            suggestionsCollectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            suggestionsCollectionView.bottomAnchor.constraint(equalTo: applyButton.topAnchor),
            
            applyButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            applyButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            applyButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
        ])
    }
    
    @objc func applyButtonPressed(_ sender: UIButton) {
        let cell = getSelectedCell() ?? nil
        let message = cell != nil ? cell?.data!.title : "Пожалуйста, выберите предложение"
        
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
        if let count = list?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = suggestionsCollectionView.dequeueReusableCell(
            withReuseIdentifier: SuggestionUICollectionViewCell.identifier,
            for: indexPath
        ) as! SuggestionUICollectionViewCell
        cell.data = list![indexPath.row]
        cell.maxWidth = suggestionsCollectionView.bounds.width
        return cell
    }
}
