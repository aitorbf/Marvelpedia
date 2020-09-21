//
//  CharacterProvider.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

final class CharacterProvider {
    
    // MARK: - Public variables
    
    var remoteDataSource: RemoteDataSourceProtocol?
}

// MARK: - CharacterProviderProtocol protocol conformance

extension CharacterProvider: CharacterProviderProtocol {
    
    func loadCharacters(offset: Int, name: String, _ completion: @escaping (CharacterCollection?, APIException?) -> Void) {
        remoteDataSource?.loadCharacters(offset: offset, name: name) {
            (response, error) in
            if error != nil {
                completion(nil, error)
            } else if let result = response {
                let characterCollection = CharacterCollectionMapper().transform(result)
                completion(characterCollection, nil)
            } else {
                completion(nil, APIException.unknownException)
            }
        }
    }
}
