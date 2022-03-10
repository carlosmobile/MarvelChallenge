//
//  LoaderSpinnerCollectionViewCell.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 10/3/22.
//

import UIKit

class LoaderSpinnerCollectionViewCell: UICollectionViewCell {

    var loaderSpinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        contentView.addSubview(loaderSpinner)
        loaderSpinner.translatesAutoresizingMaskIntoConstraints = false
        loaderSpinner.centerXAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerXAnchor).isActive = true
        loaderSpinner.centerYAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerYAnchor).isActive = true
        loaderSpinner.startAnimating()
    }
}
