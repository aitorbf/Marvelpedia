//
//  ComicProvider.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

final class ComicProvider {
    
    // MARK: - Public variables
    
    var remoteDataSource: RemoteDataSourceProtocol?
}

// MARK: - ComicProviderProtocol protocol conformance

extension ComicProvider: ComicProviderProtocol {
    
    func loadCharacterComics(characterId: Int, offset: Int, _ completion: @escaping (ComicCollection?, APIException?) -> Void) {
        remoteDataSource?.loadCharacterComics(characterId: characterId, offset: offset) {
            (response, error) in
            if error != nil {
                completion(nil, error)
            } else if let result = response {
                let comicCollection = ComicCollectionMapper().transform(result)
                completion(comicCollection, nil)
            } else {
                completion(nil, APIException.unknownException)
            }
        }
    }
}
