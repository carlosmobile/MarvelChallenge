//
//  LoginAPIViewController.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol LoginAPIViewUpdatesHandler: AnyObject {

    func updateLoginAPIView()
    func updateLoginAPIViewWithAlert(_ message: String, _ errorType: APIError)
}

class LoginAPIViewController: UIViewController, LoginAPIViewUpdatesHandler {

    //MARK: Relationships

    var presenter: LoginAPIEventHandler!
    var viewModel: LoginAPIViewModel {
        return presenter.viewModel
    }

    let loginButtonRadius: CGFloat = 8.0
    let disposeBag = DisposeBag()

    //MARK: - IBOutlets

    @IBOutlet weak var publicKeyLabel: UILabel!
    @IBOutlet weak var privateKeyLabel: UILabel!
    @IBOutlet weak var publicKeyTextField: ShakingTextField!
    @IBOutlet weak var privateKeyTextField: ShakingTextField!
    @IBOutlet weak var loginAPIButton: UIButton!

    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
        configureOutlets()
    }

    override func viewDidLayoutSubviews() {
        checkInternetConnection()
    }

    func configureBindings() {
        publicKeyTextField.rx.text
            .orEmpty
            .asObservable()
            .map({ (string) -> String in
                return string.trimmingCharacters(in: .whitespacesAndNewlines)
            })
            .bind(to: viewModel.publicKey)
            .disposed(by: disposeBag)

        let publicKeyValid = publicKeyTextField.rx.text.orEmpty
            .map { $0.count > 0 }
            .share(replay: 1)

        privateKeyTextField.rx.text
            .orEmpty
            .asObservable()
            .map({ (string) -> String in
                return string.trimmingCharacters(in: .whitespacesAndNewlines)
            })
            .bind(to: viewModel.privateKey)
            .disposed(by: disposeBag)

        let privateKeyValid = privateKeyTextField.rx.text.orEmpty
            .map { $0.count > 0 }
            .share(replay: 1)

        publicKeyValid
            .bind(onNext: { (isValidPublicKey) in
                self.viewModel.isValidPublicKey.accept(isValidPublicKey)
            })
            .disposed(by: self.disposeBag)

        privateKeyValid
            .bind(onNext: { (isValidPrivateKey) in
                self.viewModel.isValidPrivateKey.accept(isValidPrivateKey)
            })
            .disposed(by: self.disposeBag)

        privateKeyTextField.rx.controlEvent(.allEvents)
            .asObservable()
            .subscribe(onNext: { _ in

                privateKeyValid
                    .bind(onNext: { (isPrivateKeyValid) in
                        self.privateKeyTextField.rightView?.isHidden = isPrivateKeyValid
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)

        viewModel.showActivityIndicator.asObservable()
            .subscribe(onNext:{ isLoading in

                if isLoading {
                    STLoaderSpinner.sharedInstance.showActivityIndicator(title: "loading".localized)
                } else {
                    STLoaderSpinner.sharedInstance.hideActivityIndicator()
                }
            }).disposed(by: disposeBag)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        publicKeyTextField.text = ""
        privateKeyTextField.text = ""
    }

    //MARK: - UI Configuration

    private func configureOutlets() {
        title = "loginAPITitle".localized
        publicKeyLabel.text = "publicKey".localized
        privateKeyLabel.text = "privateKey".localized
        publicKeyTextField.setBottomBorder()
        privateKeyTextField.setBottomBorder()
        loginAPIButton.setTitle("loginButtonTitle".localized, for: .normal)
        loginAPIButton.layer.cornerRadius = loginButtonRadius
    }

    //MARK: - LoginAPIViewUpdatesHandler

    func updateLoginAPIView() {
        presenter.handleSendAPIKeysSuccess()
    }

    func updateLoginAPIViewWithAlert(_ message: String,  _ errorType: APIError) {
        if errorType == APIError.noInternet {
            let actionYes: () -> Void = { (
                self.checkInternetConnection()
            ) }
            self.showCustomAlertWith(
                okButtonAction: actionYes,
                title: "connectionFailedTitle".localized,
                message: "connectionFailedMessage".localized)
        } else {
            Alert.present(message, actions: [.ok(handler: {
                self.loginAPIButton.isEnabled = true
            })], from: self)
        }
    }

    //MARK: - Overrides - Hide Keyboard

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    //MARK: - Private methods

    private func checkInternetConnection() {
        if MVReachability.isConnected() {
            return
        } else {
            updateLoginAPIViewWithAlert("", .noInternet)
        }
    }

    private func shakeErrorTextField(textField: ShakingTextField) {
        textField.shake(placeHolderText: "errorWritingKey".localized) {
            self.loginAPIButton.isEnabled = true
        }
    }

    //MARK: - Action methods

    @IBAction func onLoginButton() {
        view.endEditing(true)
        loginAPIButton.isEnabled = false

        if viewModel.isValidPublicKey.value && viewModel.isValidPrivateKey.value {
            APIKeys.saveKeys(publicKey: viewModel.publicKey.value, privateKey: viewModel.privateKey.value)
            presenter.handleSendAPIKeys()
        } else {
            if !viewModel.isValidPublicKey.value {
                shakeErrorTextField(textField: publicKeyTextField)
            }
            if !viewModel.isValidPrivateKey.value {
                shakeErrorTextField(textField: privateKeyTextField)
            }
        }
    }

}
