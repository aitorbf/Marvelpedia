//
//  LocalDataSourceProtocol.swift
//  Marvelpedia
//
//  Created by Aitor on 22/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

protocol LocalDataSourceProtocol {
    
    func loadCharacters(offset: Int, name: String) -> CharacterDataWrapper?
    
    func saveCharacters(characters: CharacterDataWrapper, offset: Int, name: String)
    
    func loadCharacterComics(characterId: Int, offset: Int) -> ComicDataWrapper?
    
    func saveCharacterComics(comics: ComicDataWrapper, characterId: Int, offset: Int)
}
