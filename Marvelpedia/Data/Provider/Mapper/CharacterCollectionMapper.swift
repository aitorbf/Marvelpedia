//
//  CharacterCollectionMapper.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class CharacterCollectionMapper {
    
    func transform(_ entity: CharacterDataWrapper) -> CharacterCollection {
        var object = CharacterCollection()
        
        object.offset = entity.data?.offset
        object.total = entity.data?.total
        object.count = entity.data?.count
        object.characters = [Character]()
        if let results = entity.data?.results {
            for result in results {
                let character = CharacterMapper().transform(result)
                object.characters?.append(character)
            }
        }
        
        return object
    }
}
