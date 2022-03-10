//
//  CharacterListInteractor.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import Foundation

protocol CharacterListRequestHandler: AnyObject {

    func requestCharacters(_ from: Int?, _ nameStartsWith: String)
}

class CharacterListInteractor: CharacterListRequestHandler {

    //MARK: Relationships

    weak var presenter: CharacterListResponseHandler?

    //MARK: - RequestHandler Protocol

    func requestCharacters(_ from: Int?, _ nameStartsWith: String) {

        let isSearching = nameStartsWith != ""
        var requestOffset = ""

        if let offset = from {
            requestOffset = String(offset)
        }

        let getRequest = APIRequest(method: .get, path: Server.charactersEndpointURL)
        getRequest.queryItems?.append(URLQueryItem(name: "offset", value: requestOffset))
        if isSearching {
            getRequest.queryItems?.append(URLQueryItem(name: "nameStartsWith", value: nameStartsWith))
        }

        if MVReachability.isConnected() {
            APIClient().perform(request: getRequest) { result in
                DispatchQueue.main.async {
                    self.presenter?.characterRequestDidFinish()
                    switch result {
                    case .success(let response):
                        if let response = try? response.decode(to: CharacterDataWrapper.self) {
                            if isSearching {
                                self.presenter?.characterRequestDataSearchFilter(response: response.body.data)
                            } else {
                                self.presenter?.characterRequestDataRegular(response: response.body.data)
                            }
                        }
                        else {
                            self.presenter?.characterRequestError(message: "errorDecodeResponse".localized,
                                                                  errorType: .decodingFailure)
                        }
                    case .failure:
                        self.presenter?.characterRequestError(message: "errorNetworkRequest".localized,
                                                              errorType: .requestFailed)
                    }
                }
            }
        } else {
            presenter?.characterRequestDidFinish()
            presenter?.characterRequestError(message: "",
                                             errorType: .noInternet)
        }
    }

}
