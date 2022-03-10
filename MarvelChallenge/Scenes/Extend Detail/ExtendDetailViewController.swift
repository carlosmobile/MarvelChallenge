//
//  ExtendDetailViewController.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 11/3/22.
//

import UIKit

class ExtendDetailViewController: UIViewController {

    var extendDetailData: Item?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureOutlets()
    }

    func configureOutlets() {
        titleLabel.text = extendDetailData?.title
        descriptionLabel.text = extendDetailData?.formatDescription

        let thumbnail = (extendDetailData?.thumbnail.path)! + "." + (extendDetailData?.thumbnail.imageExtension)!
        let url = URL(string: thumbnail)
        imageView.downloadImageWithThirdPartyLibrary(fromUrl: url)
    }

    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
