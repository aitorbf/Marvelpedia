//
//  MarvelClient.swift
//  Marvelpedia
//
//  Created by Aitor on 17/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

final class MarvelClient: BaseClient {
    
    private let host: APIHost = .marvel
}

extension MarvelClient: MarvelClientProtocol {
    
    func loadCharacters(offset: Int, name: String, _ completion: @escaping (CharacterDataWrapper?, APIException?) -> Void) {
        request(Endpoint.characters(offset: offset, name: name, host: host, version: APIVersion.v1)) {
            (response, error) in
            if error != nil {
                completion(nil, error)
            } else if let resultData = response?.data {
                do {
                    let characterDataWrapper = try JSONDecoder().decode(CharacterDataWrapper.self, from: resultData)
                    completion(characterDataWrapper, nil)
                } catch let exception {
                    completion(nil, exception as? APIException)
                }
            } else {
                completion(nil, APIException.unknownException)
            }
        }
    }
    
    func loadCharacterComics(characterId: Int, _ completion: @escaping (ComicDataWrapper?, APIException?) -> Void) {
        request(.characterComics(characterId: characterId, host: host, version: .v1)) {
            (response, error) in
            if error != nil {
                completion(nil, error)
            } else if let resultData = response?.data {
                do {
                    let comicDataWrapper = try JSONDecoder().decode(ComicDataWrapper.self, from: resultData)
                    completion(comicDataWrapper, nil)
                } catch let exception {
                    completion(nil, exception  as? APIException)
                }
            } else {
                completion(nil, APIException.unknownException)
            }
        }
    }
}
