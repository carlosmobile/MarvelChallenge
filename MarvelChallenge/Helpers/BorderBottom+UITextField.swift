//
//  BorderBottom+UITextField.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//

import UIKit

private let textFieldKeysFontSize: CGFloat = 16

extension UITextField {
    func setBottomBorder() {
        borderStyle = .none
        layer.backgroundColor = UIColor.white.cgColor
        layer.shadowColor = ThemeColor.graySoft.MVColor.cgColor
        textColor = ThemeColor.blackMV.MVColor
        font = UIFont.systemFont(ofSize: textFieldKeysFontSize)
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
    }
}
