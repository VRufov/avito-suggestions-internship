//
//  CloseUIButton.swift
//  iosInternship
//
//  Created by Вадим Руфов on 4/10/22.
//

import UIKit

@IBDesignable
final class CloseUIButton: UIButton {
    static private let defaultImageConfig = UIImage.SymbolConfiguration(pointSize: K.Buttons.defaultXmarkSize, weight: .bold, scale: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setXmark(CloseUIButton.defaultImageConfig)
    }
    
    init(frame: CGRect, withImageConfiguration imageConfiguration: UIImage.Configuration) {
        super.init(frame: frame)
        setXmark(imageConfiguration)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setXmark(CloseUIButton.defaultImageConfig)
    }
    
    
    fileprivate func setXmark(_ configuration: UIImage.Configuration = defaultImageConfig) {
        let xmark = UIImage(systemName: "xmark", withConfiguration: configuration)
        self.setImage(xmark, for: .normal)
        self.tintColor = .label
    }
}

