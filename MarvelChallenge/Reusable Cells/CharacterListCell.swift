//
//  CharacterListCell.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 10/3/22.
//

import UIKit

class CharacterListCell: UITableViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!

    let characterImageCornerRadius: CGFloat = 15

    override func awakeFromNib() {
        super.awakeFromNib()
        configureOutlets()
    }

    private func configureOutlets() {
        characterNameLabel.textColor = ThemeColor.blackMV.MVColor
        characterDescriptionLabel.textColor = ThemeColor.grayMedium.MVColor
    }

    func updateCellWith(withModel model: Array<Character>, indexPath: IndexPath) {
        characterNameLabel.text = model[indexPath.row].name
        characterDescriptionLabel.text = model[indexPath.row].formatDescription
        characterImageView.layer.cornerRadius = characterImageCornerRadius

        let thumbnail = model[indexPath.row].thumbnail.standardMedium
        let url = URL(string: thumbnail)
        characterImageView.downloadImageWithThirdPartyLibrary(fromUrl: url)
    }
}
