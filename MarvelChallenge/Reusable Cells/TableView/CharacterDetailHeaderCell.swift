//
//  CharacterDetailHeaderCell.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 10/3/22.
//

import UIKit

protocol CharacterCellDelegate: AnyObject {
    func tapOnWiki(_ wikiURL: String)
}

class CharacterDetailHeaderCell: UITableViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    @IBOutlet weak var wikiButton: UIButton!

    weak var cellDelegate: CharacterCellDelegate?
    var wikiURL: String = ""
    var isWikiAvailable: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        configureOutlets()
    }

    private func configureOutlets() {
        characterNameLabel.textColor = ThemeColor.blackMV.MVColor
        characterDescriptionLabel.textColor = ThemeColor.grayMedium.MVColor
    }

    func updateCellWith(withModel model: Character) {

        for url in model.urls {
            if url.type == "wiki" {
                wikiURL = url.url
                isWikiAvailable = true
            }
        }

        if isWikiAvailable {
            wikiButton.setTitle("visitWiki".localized, for: .normal)
        } else {
            wikiButton.setTitle("visitWikiNotAvailable".localized, for: .normal)
        }
        wikiButton.isEnabled = isWikiAvailable

        characterNameLabel.text = model.name
        characterDescriptionLabel.text = model.formatDescription

        let thumbnail = model.thumbnail.fullSize
        let url = URL(string: thumbnail)
        characterImageView.downloadImageWithThirdPartyLibrary(fromUrl: url)
    }

    @IBAction func wikiAction(_ sender: Any) {
        cellDelegate?.tapOnWiki(wikiURL)
    }
}
