//
//  CharacterListViewController.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol CharacterListViewUpdatesHandler: AnyObject {
    func updateCharacterListView()
    func updateCharacterListViewWithAlert(_ message: String, _ errorType: APIError)
}

class CharacterListViewController: UIViewController, CharacterListViewUpdatesHandler {


    //MARK: Relationships

    var presenter: CharacterListEventHandler!
    var viewModel: CharacterListViewModel {
        return presenter.viewModel
    }

    let infinitePaginationScrollOffsetVelocity: CGFloat = 4
    let refreshTableSpinnerPosition: CGFloat = 20
    let estimatedTableRowHeight: CGFloat = 125

    lazy var timer = AutoSearchTimer { [weak self] in self?.performSearch() }
    let searchController = UISearchController(searchResultsController: nil)
    var searchText = ""

    let refreshControl = UIRefreshControl()
    let disposeBag = DisposeBag()
    var characterDataRegularList: [Character] = []
    var characterDataSearchFilterList: [Character] = []
    var characterDataList: [Character] = []
    var totalNumberOfCharacters = 0
    var isMaxNumberOfCharacters: Bool = false
    var isEmptyNumberOfCharacters: Bool = true
    var isLoading = false
    var isSearchingLoadMore: Bool = false
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFilteringActiveToShowFooter: Bool {
      return searchController.isActive
    }

    //MARK: - IBOutlets

    @IBOutlet weak var characterTableView: UITableView!
    @IBOutlet weak var searchFooter: SearchFooter!
    @IBOutlet weak var searchFooterBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var characterTableViewBottomConstraint: NSLayoutConstraint!

    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
        configureOutlets()
        configureSearchBar()
        configureKeyboard()
    }

    override func viewDidLayoutSubviews() {
        if isEmptyNumberOfCharacters {
            presenter.handleRequestData(from: characterDataList.count,
                                        nameStartsWith: "",
                                        requestType: .characterRegular)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "back".localized,
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
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

        viewModel.characterDataContainerRegular.asObservable()
        .subscribe(onNext:{ characterDataContainerRegular in
            if let characterData = characterDataContainerRegular {
                self.characterDataRegularList += characterData.results
            }
        }).disposed(by: disposeBag)

        viewModel.characterDataContainerSearchFilter.asObservable()
        .subscribe(onNext:{ characterDataContainerSearchFilter in
            if let characterData = characterDataContainerSearchFilter {
                if self.isSearchingLoadMore {
                    self.characterDataSearchFilterList += characterData.results
                } else {
                    self.characterDataSearchFilterList = characterData.results
                }
            }
        }).disposed(by: disposeBag)

        viewModel.isSearching.asObservable()
        .subscribe(onNext:{ isSearching in
            if isSearching {
                self.characterDataList = self.characterDataSearchFilterList
                self.resetListCounters(characterDataList: self.characterDataSearchFilterList,
                                       characterDataContainer: self.viewModel.characterDataContainerSearchFilter.value)
            } else {
                self.characterDataList = self.characterDataRegularList
                self.resetListCounters(characterDataList: self.characterDataRegularList,
                                       characterDataContainer: self.viewModel.characterDataContainerRegular.value)
            }
        }).disposed(by: disposeBag)
    }

    //MARK: - UI Configuration

    private func configureOutlets() {
        navigationItem.setHidesBackButton(true, animated: false)
        refreshControl.bounds.origin.y = refreshTableSpinnerPosition
        refreshControl.tintColor = ThemeColor.blackMV.MVColor
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        characterTableView.addSubview(refreshControl)
        characterTableView.accessibilityIdentifier = "characterTable"
        title = "charactersTitle".localized
        characterTableView.delegate = self
        characterTableView.dataSource = self
        searchController.searchBar.delegate = self
        characterTableView.tableFooterView = UIView()
        characterTableView.estimatedRowHeight = estimatedTableRowHeight
        characterTableView.rowHeight = UITableView.automaticDimension
        characterTableView.register(UINib(nibName: "LoadingCell", bundle: nil),
                                    forCellReuseIdentifier: "LoadingCell")
        characterTableView.register(UINib(nibName: "CharacterListCell", bundle: nil),
                                    forCellReuseIdentifier: "CharacterListCell")
    }

    func configureSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "searchBarPlaceholder".localized
        searchController.searchBar.searchBarStyle = UISearchBar.Style.minimal
        navigationItem.searchController = searchController
    }

    func configureKeyboard() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification,
                                       object: nil, queue: .main) { (notification) in
                                        self.handleKeyboard(notification: notification) }
        notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                       object: nil, queue: .main) { (notification) in
                                        self.handleKeyboard(notification: notification) }
    }

    //MARK: - CharacterListViewUpdatesHandler

    func updateCharacterListView() {
        isLoading = false
        let longTitleLabel = UILabel()
        longTitleLabel.text = String(characterDataList.count) + "/" + String(totalNumberOfCharacters)
        longTitleLabel.sizeToFit()
        let rightItem = UIBarButtonItem(customView: longTitleLabel)
        navigationItem.rightBarButtonItem = rightItem
        characterTableView.reloadData()
    }

    func updateCharacterListViewWithAlert(_ message: String, _ errorType: APIError) {
        if errorType == APIError.noInternet {
            let actionYes: () -> Void = { (
                self.presenter.handleRequestData(from: self.characterDataList.count,
                                                 nameStartsWith: "",
                                                 requestType: .characterRegular)
            ) }
            self.showCustomAlertWith(
                okButtonAction: actionYes,
                title: "connectionFailedTitle".localized,
                message: "connectionFailedMessage".localized)
        } else {
            Alert.present(message, actions: [.ok(handler: nil)], from: self)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height

        if (contentHeight > 0) && !isLoading {
            if (offsetY > contentHeight - frameHeight * infinitePaginationScrollOffsetVelocity) {
                loadMoreData()
            }
        }
    }

    func handleKeyboard(notification: Notification) {

        guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
            searchFooterBottomConstraint.constant = 0
            characterTableViewBottomConstraint.constant = 0
            view.layoutIfNeeded()
            return
        }

        guard let info = notification.userInfo,
              let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return
        }

        let keyboardHeight = keyboardFrame.cgRectValue.size.height
        let keyBoardAndSafeAreaHeight = view.safeAreaInsets.bottom - keyboardHeight
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.searchFooterBottomConstraint.constant = keyBoardAndSafeAreaHeight
            self.characterTableViewBottomConstraint.constant = self.searchFooter.frame.height - keyBoardAndSafeAreaHeight
            self.view.layoutIfNeeded()
        })
    }

    //MARK: - Private methods

    @objc private func refresh() {
      characterTableView.reloadData()
      refreshControl.endRefreshing()
    }

    private func loadMoreData() {
        if !isLoading && !isMaxNumberOfCharacters {
            isLoading = true
            if viewModel.isSearching.value {
                isSearchingLoadMore = true
                presenter.handleRequestData(from: characterDataList.count,
                                            nameStartsWith: searchText,
                                            requestType: .characterSearchLoadMore)
            } else {
                presenter.handleRequestData(from: characterDataList.count,
                                            nameStartsWith: "",
                                            requestType: .characterRegularLoadMore)
            }
        }
    }

    private func resetListCounters(characterDataList: [Character], characterDataContainer: CharacterDataContainer?) {
        totalNumberOfCharacters = characterDataContainer?.total ?? 0
        isMaxNumberOfCharacters = characterDataList.count == (characterDataContainer?.total ?? 0)
        isEmptyNumberOfCharacters = characterDataList.count == 0
        searchFooter.updateFiltering(filteredItemCount: characterDataList.count,
                                                    of: totalNumberOfCharacters)
    }

}

//MARK: - UITableView Configuration

enum Table: Int {
  case Characters = 0
  case BottomLoader = 1

  func numberOfSections() -> Int {
    switch self {
    case .Characters:
        return 2
    case .BottomLoader:
        return 1
    }
  }
}

//MARK: - UITableViewDataSource

extension CharacterListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Table.Characters.rawValue {
            return characterDataList.count
        } else {
            if isEmptyNumberOfCharacters {
                return 0
            } else {
                return Table.BottomLoader.rawValue
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if isMaxNumberOfCharacters {
            return Table.numberOfSections(.BottomLoader)()
        } else {
            return Table.numberOfSections(.Characters)()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()

        switch indexPath.section {

        case Table.Characters.rawValue:
            guard let characterListCell = tableView.dequeueReusableCell(withIdentifier: "CharacterListCell") as? CharacterListCell else {
                return cell
            }
            characterListCell.updateCellWith(withModel: characterDataList, indexPath: indexPath)
            let backgroundView = UIView()
            backgroundView.backgroundColor = ThemeColor.graySelectedCell.MVColor
            characterListCell.selectedBackgroundView = backgroundView

            return characterListCell

        case Table.BottomLoader.rawValue:
            guard let loadingCell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell") as? LoadingCell else {
                return cell
            }
            loadingCell.activityIndicator.startAnimating()

            return loadingCell

        default:
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

extension CharacterListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.handleItemSelected(character: characterDataList[indexPath.row])
    }
}

//MARK: - UISearchBarDelegate

extension CharacterListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        timer.activate()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchFooter.setIsFilteringToShow(filteredItemCount: characterDataList.count,
                                          of: totalNumberOfCharacters)
    }

    func performSearch() {
        timer.cancel()
        if isSearchBarEmpty {
            searchEndBackToRegularData()
        } else {
            isSearchingLoadMore = false
            presenter.handleRequestData(from: characterDataList.count, nameStartsWith: searchText, requestType: .characterSearch)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchFooter.setNotFiltering()
        searchEndBackToRegularData()
    }

    private func searchEndBackToRegularData() {
        viewModel.isSearching.accept(false)
        updateCharacterListView()
    }

}
