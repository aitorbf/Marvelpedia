//
//  RemoteDataSource.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

final class RemoteDataSource {
    
    // MARK: - Public variables
    
    var marvelClient: MarvelClientProtocol?
}

// MARK: - RemoteDataSourceProtocol protocol conformance

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func loadCharacters(_ completion: @escaping (CharacterDataWrapper?, APIException?) -> Void) {
        marvelClient?.loadCharacters() {
            (response, error) in
            if error != nil {
                completion(nil, error)
            } else if let characters = response {
                completion(characters, nil)
            } else {
                completion(nil, APIException.unknownException)
            }
        }
    }
    
    func loadCharacterComics(characterId: Int, _ completion: @escaping (ComicDataWrapper?, APIException?) -> Void) {
        marvelClient?.loadCharacterComics(characterId: characterId) {
            (response, error) in
            if error != nil {
                completion(nil, error)
            } else if let comics = response {
                completion(comics, nil)
            } else {
                completion(nil, APIException.unknownException)
            }
        }
    }
}
