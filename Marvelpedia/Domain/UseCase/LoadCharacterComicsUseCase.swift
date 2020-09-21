//
//  LoadCharacterComicsUseCase.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

final class LoadCharacterComicsUseCase: BaseUseCase {
    
    // MARK: - Public variables
    
    var comicProvider: ComicProviderProtocol?
}

extension LoadCharacterComicsUseCase: LoadCharacterComicsUseCaseProtocol {
    
    func execute(characterId: Int, _ completion: @escaping (ComicCollection?, APIException?) -> Void) {
        comicProvider?.loadCharacterComics(characterId: characterId) {
            (response, error) in
            if error != nil {
                completion(nil, error)
            } else if let comicCollection = response {
                completion(comicCollection, nil)
            } else {
                completion(nil, APIException.unknownException)
            }
        }
    }
}
