//
//  CharacterMapper.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class CharacterMapper {
    
    func transform(_ entity: CharacterEntity) -> Character {
        var object = Character()
        
        object.id = entity.id
        object.name = entity.name
        object.description = entity.description
        if let path = entity.thumbnail?.path, let imageExtension = entity.thumbnail?.imageExtension {
            object.thumbnail = "\(path).\(imageExtension)"
        }
        
        return object
    }
}
