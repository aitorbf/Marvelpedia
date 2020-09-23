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
    var localDataSource: LocalDataSourceProtocol?
}

// MARK: - ComicProviderProtocol protocol conformance

extension ComicProvider: ComicProviderProtocol {
    
    func loadCharacterComics(characterId: Int, offset: Int, _ completion: @escaping (ComicCollection?, APIException?) -> Void) {
        if let comics = localDataSource?.loadCharacterComics(characterId: characterId, offset: offset) {
            let comicCollection = ComicCollectionMapper().transform(comics)
            completion(comicCollection, nil)
        } else {
            remoteDataSource?.loadCharacterComics(characterId: characterId, offset: offset) {
                (response, error) in
                if error != nil {
                    completion(nil, error)
                } else if let result = response {
                    self.localDataSource?.saveCharacterComics(comics: result, characterId: characterId, offset: offset)
                    let comicCollection = ComicCollectionMapper().transform(result)
                    completion(comicCollection, nil)
                } else {
                    completion(nil, APIException.unknownException)
                }
            }
        }
    }
}
