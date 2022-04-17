//
//  UIImageViewExtension.swift
//  iosInternship
//
//  Created by Вадим Руфов on 4/13/22.
//

import UIKit

private let downloader = CachedImageDownloader(imageDownloader: ImageDownloader())

extension UIImageView {

    public func setImageFromServerURL(urlString: String) {
        guard let imageURL = URL(string: urlString) else { return }
        downloader.downloadImage(with: imageURL) { image in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
