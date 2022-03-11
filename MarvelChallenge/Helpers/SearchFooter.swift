//
//  SearchFooter.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 10/3/22.
//

import UIKit

class SearchFooter: UIView {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

    override func draw(_ rect: CGRect) {
        label.frame = bounds
    }

    func setNotFiltering() {
        label.text = ""
        hideFooter()
    }

    func updateFiltering(filteredItemCount: Int, of totalItemCount: Int) {
        label.text = String(format: "charactersFooterCount".localized, filteredItemCount, totalItemCount)
    }

    func setIsFilteringToShow(filteredItemCount: Int, of totalItemCount: Int) {
        if (filteredItemCount == 0) {
            label.text = "noItemsMatch".localized
        } else {
            label.text = String(format: "charactersFooterCount".localized, filteredItemCount, totalItemCount)
        }
        showFooter()
    }

    private func hideFooter() {
        UIView.animate(withDuration: 0.7) {
            self.alpha = 0.0
        }
    }

    private func showFooter() {
        UIView.animate(withDuration: 0.7) {
            self.alpha = 1.0
        }
    }

    private func configureView() {
        backgroundColor = ThemeColor.blackMV.MVColor
        alpha = 0.0
        label.textAlignment = .center
        label.textColor = .white
        addSubview(label)
    }
}
