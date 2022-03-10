//
//  LoadingCell.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 10/3/22.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureOutlets()
    }

    private func configureOutlets() {
        backgroundColor = .clear
        activityIndicator.color = ThemeColor.blackMV.MVColor
    }
}
