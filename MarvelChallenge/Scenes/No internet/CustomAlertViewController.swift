//
//  CustomAlertViewController.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//

import UIKit

class CustomAlertViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!

    var alertTitle: String = ""
    var alertMessage: String = ""
    var imageItem: UIImage?
    var okButtonAct: (() ->())?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        containerView.layer.cornerRadius = 20.0
        containerView.layer.masksToBounds = true
        addCornerRadiusWithShadowToButton(color: .lightGray, borderColor: .clear, cornerRadius: 10)
        titleLabel.text = alertTitle
        messageLabel.text = alertMessage
        imageItem = UIImage(named: ThemeImage.mvNoInternet.MVImage)
        okButton.setTitle("retry".localized, for: .normal)
    }

    func addCornerRadiusWithShadowToButton(color: UIColor, borderColor: UIColor, cornerRadius: CGFloat) {
        okButton.layer.shadowColor = color.cgColor
        okButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        okButton.layer.shadowOpacity = 1.0
        okButton.layer.shadowRadius = 6.0
        okButton.layer.cornerRadius = cornerRadius
        okButton.layer.borderColor = borderColor.cgColor
        okButton.layer.borderWidth = 1.0
        okButton.layer.masksToBounds = false
    }

    // MARK: - IBAction Methods

    @IBAction func okayButtonAction(sender: UIButton) {
        dismiss(animated: true, completion: nil)
        okButtonAct?()
    }

}
