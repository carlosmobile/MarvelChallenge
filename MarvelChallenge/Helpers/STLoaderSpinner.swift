//
//  STLoaderSpinner.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//

import UIKit

class STLoaderSpinner {

    private let loadingViewWidth = 90.0
    private let loadingViewHeight = 90.0
    private let activitiIndicatorWidth = 40.0
    private let activitiIndicatorHeight = 40.0
    private let loadingTextSize: CGFloat = 12
    private let loadingViewCornerRadius: CGFloat = 10
    private let activityIndicatorCenterOffset: CGFloat = 8
    private let activityTextYOffset: CGFloat = 35

    private var container: UIView = UIView()
    private var loadingView: UIView = UIView()
    private let loadingTextLabel = UILabel()
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static let sharedInstance = STLoaderSpinner()

    func showActivityIndicator(title: String) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        if let window = windowScene?.windows.first(where: { (window) -> Bool in window.isKeyWindow}) {
            container.frame = CGRect(x: 0.0, y: 0.0, width: (window.frame.width), height: (window.frame.height))
            container.backgroundColor = .clear
            window.addSubview(container)
        }

        loadingView.frame = CGRect(x: 0.0, y: 0.0, width: loadingViewWidth, height: loadingViewHeight)
        loadingView.center = container.center
        loadingView.backgroundColor = ThemeColor.grayLight.MVColor
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = loadingViewCornerRadius

        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: activitiIndicatorWidth, height: activitiIndicatorHeight)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: (loadingView.frame.size.height / 2) - activityIndicatorCenterOffset)
        activityIndicator.color = ThemeColor.blackMV.MVColor

        loadingTextLabel.text = title
        loadingTextLabel.font = UIFont.boldSystemFont(ofSize: loadingTextSize)
        loadingTextLabel.sizeToFit()
        loadingTextLabel.textColor = ThemeColor.blackMV.MVColor
        loadingTextLabel.center = CGPoint(x: activityIndicator.center.x, y: activityIndicator.center.y + activityTextYOffset)

        loadingView.addSubview(loadingTextLabel)
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)

        activityIndicator.startAnimating()
    }

    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }

    init() {
    }
}

