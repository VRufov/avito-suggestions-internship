//
//  Constants.swift
//  iosInternship
//
//  Created by Вадим Руфов on 4/10/22.
//

import Foundation
import UIKit

struct K {
    struct Colors {
        static let gray = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        static let blue = UIColor(red: 75/255, green: 173/255, blue: 255/255, alpha: 1.0)
    }
    
    struct Buttons {
        static let defaultXmarkSize: CGFloat = 25.0
        static let defaultCornerRadius: CGFloat = 8.0
    }
    
    struct Labels {
        static let hugeTitleSize: CGFloat = 30.0
        static let largeTitleSize: CGFloat = 26.0
        static let mediumTitleSize: CGFloat = 22.0
    }
    
    struct Spacing {
        static let space60: CGFloat = 60.0
        static let space20: CGFloat = 20.0
        static let space10: CGFloat = 10.0
    }
    
    struct Layers {
        static let defaultLayerRadius: CGFloat = 10.0
    }
    
    struct InsetOffsets {
        static let collectionViewDefaultOffset: CGFloat = 20
    }
}
