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
    
    func loadCharacters(_ completion: @escaping (CharacterDataWrapper?, APIException?) -> Void) {
        request(.characters(host: host, version: .v1)) {
            (response, error) in
            if error != nil {
                completion(nil, error)
            } else if let resultData = response?.data {
                do {
                    let fixture = try JSONDecoder().decode(CharacterDataWrapper.self, from: resultData)
                    completion(fixture, nil)
                } catch let exception {
                    completion(nil, exception  as? APIException)
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
                    let playerMaster = try JSONDecoder().decode(ComicDataWrapper.self, from: resultData)
                    completion(playerMaster, nil)
                } catch let exception {
                    completion(nil, exception  as? APIException)
                }
            } else {
                completion(nil, APIException.unknownException)
            }
        }
    }
}