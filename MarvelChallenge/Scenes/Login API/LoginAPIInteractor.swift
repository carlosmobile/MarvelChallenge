//
//  LoginAPIInteractor.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import Foundation

protocol LoginAPIRequestHandler: AnyObject {

    func requestCharacters()
}

class LoginAPIInteractor: LoginAPIRequestHandler {

    //MARK: Relationships

    weak var presenter: LoginAPIResponseHandler?

    //MARK: - RequestHandler Protocol

    func requestCharacters() {

        let getRequest = APIRequest(method: .get, path: Server.charactersEndpointURL)

        if MVReachability.isConnected() {
            APIClient().perform(request: getRequest) { result in
                DispatchQueue.main.async {
                    self.presenter?.apiRequestDidFinish()
                    switch result {
                    case .success(let response):
                        if let response = try? response.decode(to: CharacterDataWrapper.self) {
                            self.presenter?.apiRequestData(response: response.body.data)
                        }
                        else {
                            if response.statusCode == 401 {
                                self.presenter?.apiRequestError(message: "invalidCredentials".localized,
                                                                errorType: .requestFailed)
                            } else {
                                self.presenter?.apiRequestError(message: "errorDecodeResponse".localized,
                                                                errorType: .decodingFailure)
                            }
                        }
                    case .failure:
                        self.presenter?.apiRequestError(message: "errorNetworkRequest".localized,
                                                        errorType: .requestFailed)
                    }
                }
            }
        } else {
            presenter?.apiRequestDidFinish()
            presenter?.apiRequestError(message: "",
                                       errorType: .noInternet)
        }
    }

}
