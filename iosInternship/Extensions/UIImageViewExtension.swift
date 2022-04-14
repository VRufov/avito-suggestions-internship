//
//  UIImageViewExt.swift
//  iosInternship
//
//  Created by Вадим Руфов on 4/13/22.
//

import UIKit

extension UIImageView {

    public func setImageFromServerURL(urlString: String) {
        DispatchQueue.global().async(execute: { () -> Void in
            if let url = NSURL(string: urlString)  {
                if let data = NSData(contentsOf: url as URL) {
                    let imageAux = UIImage(data: data as Data)
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.image = imageAux
                    })
                }
            }
        })

    }
}
