//
//  ThemeManager.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//

import UIKit

enum ThemeColor: Int {

    case `default`, black, white, grayMedium, graySelectedCell,
    grayLight, graySoft, redError, blackMV

    //MARK: - Colors

    var MVColor: UIColor {
        switch self {
        case .default:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .black:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .white:
            return #colorLiteral(red: 0.9492354989, green: 0.9486114383, blue: 0.9704449773, alpha: 1)
        case .grayMedium:
            return #colorLiteral(red: 0.5569333434, green: 0.5567089319, blue: 0.5654134154, alpha: 1)
        case .grayLight:
            return #colorLiteral(red: 0.8982589245, green: 0.8976286054, blue: 0.9194687009, alpha: 1)
        case .graySoft:
            return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        case .graySelectedCell:
            return #colorLiteral(red: 0.9699652791, green: 0.9680824876, blue: 0.9988468289, alpha: 1)
        case .redError:
            return #colorLiteral(red: 0.9588698745, green: 0, blue: 0, alpha: 1)
        case .blackMV:
            return #colorLiteral(red: 0.3205151558, green: 0.3291320801, blue: 0.3377395272, alpha: 1)
        }
    }

}

enum ThemeImage: String {

    case `default`, mvDefaultNoImage, mvFabUnselectedImage, mvFabSelectedImage, mvNoInternet

    //MARK: - Images

    var MVImage: String {
        switch self {
        case .default:
            return "default"
        case .mvDefaultNoImage:
            return "mvDefault"
        case .mvFabUnselectedImage:
            return "fabUnselected"
        case .mvFabSelectedImage:
            return "fabSelected"
        case .mvNoInternet:
            return "mvDeadpool"
        }
    }
}
