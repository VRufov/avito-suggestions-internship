//
//  ImageLoaderService.swift
//  iosInternship
//
//  Created by Вадим Руфов on 4/17/22.
//

import Foundation
import UIKit


class ImageDownloader {
    func downloadImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { imageData, _, error in
            if let error = error {
                assertionFailure("Image download error \(error.localizedDescription)")
            } else if let data = imageData, let image = UIImage(data: data) {
                completion(image)
            }
        }.resume()
    }
}

class CachedImageDownloader {
    private let imageDownloader: ImageDownloader
    private var cache: [URL: UIImage] = [:]
    private let queue = DispatchQueue(label: "\(CachedImageDownloader.self)")
    
    init(imageDownloader: ImageDownloader) {
        self.imageDownloader = imageDownloader
    }
    
    private func cacheImage(_ image: UIImage, for url: URL) {
        queue.async { [weak self] in
            self?.cache[url] = image
        }
    }
    
    private func cachedImage(for url: URL) -> UIImage? {
        queue.sync {
            return cache[url]
        }
    }
    
    func downloadImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cachedImage(for: url) {
            completion(cachedImage)
        } else {
            imageDownloader.downloadImage(with: url) { [weak self] image in
                if let image = image {
                    self?.cacheImage(image, for: url)
                    completion(image)
                } else {
                    assertionFailure("Image download error")
                }
            }
        }
    }
}
