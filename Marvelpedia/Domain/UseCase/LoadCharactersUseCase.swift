//
//  LoadCharactersUseCase.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

final class LoadCharactersUseCase: BaseUseCase {
    
    // MARK: - Public variables
    
    var characterProvider: CharacterProviderProtocol?
}

extension LoadCharactersUseCase: LoadCharactersUseCaseProtocol {
    
    func execute(_ completion: @escaping (CharacterCollection?, APIException?) -> Void) {
        characterProvider?.loadCharacters() {
            (response, error) in
            if error != nil {
                completion(nil, error)
            } else if let characterCollection = response {
                completion(characterCollection, nil)
            } else {
                completion(nil, APIException.unknownException)
            }
        }
    }
}
