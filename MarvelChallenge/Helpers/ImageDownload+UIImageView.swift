//
//  ImageDownload+UIImageView.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 10/3/22.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadImageWithThirdPartyLibrary(fromUrl: URL?) {
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: fromUrl,
            placeholder: UIImage(named: ThemeImage.mvDefaultNoImage.MVImage),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
