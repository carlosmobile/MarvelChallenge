//
//  CharacterDetailViewController.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 10/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol CharacterDetailViewUpdatesHandler: AnyObject {

    func updateItemsView(type: ItemType)
    func updateCharacterDetailViewWithAlert(_ message: String, _ errorType: APIError)
}

class CharacterDetailViewController: UIViewController, CharacterDetailViewUpdatesHandler {

    //MARK: Relationships

    var presenter: CharacterDetailEventHandler!

    var viewModel: CharacterDetailViewModel {
        return presenter.viewModel
    }

    var characterDetailData: Character?
    var itemsComicsDetailData: [Item] = []
    var itemsSeriesDetailData: [Item] = []
    var isMaxNumberOfComicsItems: Bool = false
    var isMaxNumberOfSeriesItems: Bool = false
    var isLoading = false
    var isLoadingMoreData = false
    let disposeBag = DisposeBag()

    var comicSize: CGFloat = 0
    var serieSize: CGFloat = 0

    //MARK: - IBOutlets

    @IBOutlet weak var characterDetailTableView: UITableView!

    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
        configureOutlets()
    }

    override func viewDidLayoutSubviews() {
        checkAndUpdateCharacterItemsAvailable()
    }

    func configureBindings() {
        viewModel.showActivityIndicator.asObservable()
        .subscribe(onNext:{ isLoading in

          if isLoading {
            STLoaderSpinner.sharedInstance.showActivityIndicator(title: "loading".localized)
          } else {
            STLoaderSpinner.sharedInstance.hideActivityIndicator()
          }

        }).disposed(by: disposeBag)

        viewModel.characterData.asObservable()
        .subscribe(onNext:{ characterData in

            if let character = characterData {
                self.characterDetailData = character
            }

        }).disposed(by: disposeBag)

        viewModel.itemDataContainer.asObservable()
        .subscribe(onNext:{ itemDataContainer in

            if let itemData = itemDataContainer {
                if itemDataContainer?.type == .Comics {
                    self.itemsComicsDetailData += itemData.results
                    self.isMaxNumberOfComicsItems = self.itemsComicsDetailData.count >= itemData.total
                }
                if itemDataContainer?.type == .Series {
                    self.itemsSeriesDetailData += itemData.results
                    self.isMaxNumberOfSeriesItems = self.itemsSeriesDetailData.count >= itemData.total
                }
            }

        }).disposed(by: disposeBag)
    }

    //MARK: - UI Configuration

    private func configureOutlets() {
        title = "detailTitle".localized
        characterDetailTableView.delegate = self
        characterDetailTableView.dataSource = self
        characterDetailTableView.allowsSelection = false
        characterDetailTableView.tableFooterView = UIView()
        characterDetailTableView.rowHeight = UITableView.automaticDimension
        characterDetailTableView.register(UINib(nibName: "CharacterDetailHeaderCell", bundle: nil), forCellReuseIdentifier: "CharacterDetailHeaderCell")
        characterDetailTableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        characterDetailTableView.separatorStyle = .none
    }

    //MARK: - CharacterDetailViewUpdatesHandler

    func updateItemsView(type: ItemType) {
        isLoading = false
        if isLoadingMoreData {
            for cell in characterDetailTableView.visibleCells {
                if (cell as? DetailTableViewCell)?.type == type {
                    (cell as? DetailTableViewCell)?.itemsData = getItemDataFromItemType(type)
                    (cell as? DetailTableViewCell)?.collectionView.reloadData()
                }
            }
        } else {
            characterDetailTableView.reloadRows(at: [IndexPath(row: type.rawValue+1, section: 0)], with: .fade)
        }
    }

    func updateCharacterDetailViewWithAlert(_ message: String, _ errorType: APIError) {
        if errorType == APIError.noInternet {
            let actionYes: () -> Void = { (
                self.checkAndUpdateCharacterItemsAvailable()
            ) }
            self.showCustomAlertWith(
                okButtonAction: actionYes,
                title: "connectionFailedTitle".localized,
                message: "connectionFailedMessage".localized)
        } else {
            Alert.present(message, actions: [.ok(handler: nil)], from: self)
        }
    }

    //MARK: - Private methods

    private func checkAndUpdateCharacterItemsAvailable() {
        characterDetailData?.itemsList.forEach { (name, value) in
            if value > 0 {
                switch name {
                case ItemType.title(.Comics)():
                    comicSize = TableRow.rowSize(.Comics)()
                case ItemType.title(.Series)():
                    serieSize = TableRow.rowSize(.Series)()
                default:
                    return
                }
                presenter.handleViewUpdateITems(offset: 0, type: getTypeFromStringName(name))
            }
        }
    }
}

//MARK: - UITableView Configuration

enum TableRow : Int {
    case Character = 0
    case Comics = 1
    case Series = 2
    static let allValues = [TableRow.Character, TableRow.Comics, TableRow.Series]

    func rowSize() -> CGFloat {
        switch self {
        case .Character:
            return UITableView.automaticDimension
        case .Comics, .Series:
            return 220
        }
    }
}

//MARK: - UITableViewDataSource

extension CharacterDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableRow.allValues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()

        switch indexPath.row {
        case TableRow.Character.rawValue:
            guard let characterDetailCell = tableView.dequeueReusableCell(withIdentifier: "CharacterDetailHeaderCell") as? CharacterDetailHeaderCell else { return cell }

            characterDetailCell.updateCellWith(withModel: characterDetailData!)

            characterDetailCell.cellDelegate = self

            return characterDetailCell
        case TableRow.Comics.rawValue, TableRow.Series.rawValue:
            guard let itemsCell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell") as? DetailTableViewCell else { return cell }

            itemsCell.selectionStyle = .none
            switch indexPath.row {
            case TableRow.Comics.rawValue:
                itemsCell.categoryLabel.text = ItemType.Comics.title()
                itemsCell.updateCellWith(rowData: itemsComicsDetailData, type: .Comics)
            case TableRow.Series.rawValue:
                itemsCell.categoryLabel.text = ItemType.Series.title()
                itemsCell.updateCellWith(rowData: itemsSeriesDetailData, type: .Series)
            default:
                return cell
            }

            itemsCell.cellDelegate = self

            return itemsCell
        default:
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

extension CharacterDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case TableRow.Character.rawValue:
            return TableRow.rowSize(.Character)()
        case TableRow.Comics.rawValue:
            return comicSize
        case TableRow.Series.rawValue:
            return serieSize
        default:
            return 0
        }
    }
}

//MARK: - CollectionViewCellDelegate

extension CharacterDetailViewController: CollectionViewCellDelegate {
    func loadMoreData(_ type: ItemType) {

        if type == .Comics && isMaxNumberOfComicsItems {
            return
        }
        if type == .Series && isMaxNumberOfSeriesItems {
            return
        }

        if !isLoading {
            isLoading = true
            isLoadingMoreData = true
            presenter.handleViewUpdateITems(offset: getItemDataFromItemType(type).count, type: type)
        }
    }

    func collectionView(collectionviewcell: DetailCollectionViewCell?, index: Int, didTappedInTableViewCell: DetailTableViewCell) {
        presenter.handleItemSelected(extendedDetail: didTappedInTableViewCell.itemsData[index])
    }
}

//MARK: - CharacterCellDelegate

extension CharacterDetailViewController: CharacterCellDelegate {
    func tapOnWiki(_ wikiURL: String) {
        presenter.handleWikiSelected(wikiURL)
    }
}

//MARK: - Handle item types

extension CharacterDetailViewController {
    private func getItemDataFromItemType(_ type: ItemType) -> [Item] {
        switch type {
        case .Comics:
            return itemsComicsDetailData
        case .Series:
            return itemsSeriesDetailData
        default:
            return []
        }
    }

    private func getTypeFromStringName(_ typeName: String) -> ItemType {
        switch typeName {
        case ItemType.title(.Comics)():
            return .Comics
        case ItemType.title(.Series)():
            return .Series
        default:
            return .Error
        }
    }
}
