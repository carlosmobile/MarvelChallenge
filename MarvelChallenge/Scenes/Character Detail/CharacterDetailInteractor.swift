//
//  CharacterDetailInteractor.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 10/3/22.
//  Copyright (c) 2022 Carlos. All rights reserved.
//

import Foundation

protocol CharacterDetailRequestHandler: AnyObject {

    func requestDetailItems(offset: Int, _ id: Int, _ type: ItemType)
}

class CharacterDetailInteractor: CharacterDetailRequestHandler {

    //MARK: Relationships

    weak var presenter: CharacterDetailResponseHandler?

    //MARK: - RequestHandler Protocol

    func requestDetailItems(offset: Int, _ id: Int, _ type: ItemType) {

        let getRequest = APIRequest(method: .get, path: Server.charactersEndpointURL + String("/\(id)") + type.pathType())
        getRequest.queryItems?.append(URLQueryItem(name: "offset", value: String(offset)))

        if MVReachability.isConnected() {
            APIClient().perform(request: getRequest) { result in
                DispatchQueue.main.async {
                    self.presenter?.characterDetailRequestDidFinish()
                    switch result {
                    case .success(let response):
                        if let response = try? response.decode(to: ItemDataWrapper.self) {
                            var responseDataWithType = response.body.data
                            responseDataWithType.type = type
                            self.presenter?.characterItemsRequestData(response: responseDataWithType)
                        } else {
                            self.presenter?.characterDetailRequestError(message: "errorDecodeResponse".localized,
                                                                        errorType: .decodingFailure)
                        }
                    case .failure:
                        self.presenter?.characterDetailRequestError(message: "errorNetworkRequest".localized,
                                                                    errorType: .requestFailed)
                    }
                }
            }
        } else {
            presenter?.characterDetailRequestDidFinish()
            presenter?.characterDetailRequestError(message: "",
                                                   errorType: .noInternet)
        }
    }

}
