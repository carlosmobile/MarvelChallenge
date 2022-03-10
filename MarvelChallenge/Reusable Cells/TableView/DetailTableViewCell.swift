//
//  DetailTableViewCell.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 10/3/22.
//

import UIKit

protocol CollectionViewCellDelegate: AnyObject {
    func collectionView(collectionviewcell: DetailCollectionViewCell?, index: Int, didTappedInTableViewCell: DetailTableViewCell)
    func loadMoreData(_ type: ItemType)
}

class DetailTableViewCell: UITableViewCell {

    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!

    let collectionCellWidthSize = 100
    let collectionCellHeightSize = 180
    let collectionCellMinimumLineSpacing: CGFloat = 2
    let collectionMinimumInteritemSpacing: CGFloat = 5

    weak var cellDelegate: CollectionViewCellDelegate?
    var itemsData: [Item] = []
    var type: ItemType?
    var loaderSpinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        configureOutlets()
    }

    private func configureOutlets() {
        categoryLabel.textColor = ThemeColor.blackMV.MVColor
        let backgroundView = UIView()
        backgroundView.backgroundColor = ThemeColor.white.MVColor
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: collectionCellWidthSize, height: collectionCellHeightSize)
        flowLayout.minimumLineSpacing = collectionCellMinimumLineSpacing
        flowLayout.minimumInteritemSpacing = collectionMinimumInteritemSpacing
        collectionView.collectionViewLayout = flowLayout
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.accessibilityIdentifier = "detailCollection"

        collectionView.addSubview(loaderSpinner)
        loaderSpinner.translatesAutoresizingMaskIntoConstraints = false
        loaderSpinner.centerXAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerXAnchor).isActive = true
        loaderSpinner.centerYAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerYAnchor).isActive = true
        loaderSpinner.startAnimating()

        collectionView.register(UINib(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailCollectionCell")
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if (indexPath.row == itemsData.count - 1 ) {
            if let itemType = type {
                cellDelegate?.loadMoreData(itemType)
            }
         }
    }

}

extension DetailTableViewCell: UICollectionViewDelegate {

    func updateCellWith(rowData: [Item], type: ItemType) {
        itemsData = rowData
        self.type = type
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionCell", for: indexPath) as? DetailCollectionViewCell {
            loaderSpinner.removeFromSuperview()
            let thumbnail = itemsData[indexPath.row].thumbnail.portraitMedium
            let url = URL(string: thumbnail)
            cell.imageView.downloadImageWithThirdPartyLibrary(fromUrl: url)
            cell.titleLabel.text = itemsData[indexPath.row].title

            return cell
        }
        return UICollectionViewCell()
    }
}

extension DetailTableViewCell: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: collectionMinimumInteritemSpacing, bottom: 0, right: collectionMinimumInteritemSpacing)
    }
}

extension DetailTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? DetailCollectionViewCell
        cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
}
