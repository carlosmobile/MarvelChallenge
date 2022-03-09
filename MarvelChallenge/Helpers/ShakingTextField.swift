//
//  ShakingTextField.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//

import UIKit

private let textFieldKeysPlaceHolderSize: CGFloat = 14
private let animationOffset: CGFloat = 4
private let animationDuration: Double = 0.05
private let animationRepeat: Float = 5

class ShakingTextField: UITextField {
    func shake(placeHolderText: String, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: { () -> Void in
          self.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: ThemeColor.redError.MVColor])
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = animationDuration
            animation.repeatCount = animationRepeat
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - animationOffset, y: self.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + animationOffset, y: self.center.y))

            self.textColor = ThemeColor.redError.MVColor

            self.layer.add(animation, forKey: "position")
        }, completion: { (finished: Bool) -> Void in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [
                                             NSAttributedString.Key.foregroundColor: ThemeColor.graySoft.MVColor,
                                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFieldKeysPlaceHolderSize)])
                self.textColor = ThemeColor.blackMV.MVColor
                completion()
            }
        })
    }

}
