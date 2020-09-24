//
//  LocalDataSource.swift
//  Marvelpedia
//
//  Created by Aitor on 22/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation
import Cache

final class LocalDataSource {
    
    // MARK: - Enums
    
    enum Key {
        static let characters   = "characters"
        static let comics       = "comics"
    }
    
    enum StorageName {
        static let characters   = "Marvelpedia_Characteres"
        static let comics       = "Marvelpedia_Comics"
    }
    
    // MARK: Private constants
    
    private let charactersStorage = try? Storage(
        diskConfig: DiskConfig(
            name: StorageName.characters,
            expiry: .seconds(TimeInterval(3600)),
            maxSize: 10000,
            directory: nil,
            protectionType: .complete
        ),
        memoryConfig: MemoryConfig(
            expiry: .seconds(TimeInterval(3600)),
            countLimit: 50,
            totalCostLimit: 0
        ),
        transformer: TransformerFactory.forCodable(ofType: CharacterDataWrapper.self)
    )
    private let comicsStorage = try? Storage(
        diskConfig: DiskConfig(
            name: StorageName.comics,
            expiry: .seconds(TimeInterval(3600)),
            maxSize: 10000,
            directory: nil,
            protectionType: .complete
        ),
        memoryConfig: MemoryConfig(
            expiry: .seconds(TimeInterval(3600)),
            countLimit: 50,
            totalCostLimit: 0
        ),
        transformer: TransformerFactory.forCodable(ofType: ComicDataWrapper.self)
    )
}

// MARK: - LocalDataSourceProtocol protocol conformance

extension LocalDataSource: LocalDataSourceProtocol {
    
    func loadCharacters(offset: Int, name: String) -> CharacterDataWrapper? {
        var characterName = name
        if characterName == "" {
            characterName = "all"
        }
        let objectKey = "\(Key.characters)_\(characterName)_\(offset)"
        return try? charactersStorage?.object(forKey: objectKey)
    }
    
    func saveCharacters(characters: CharacterDataWrapper, offset: Int, name: String) {
        var characterName = name
        if characterName == "" {
            characterName = "all"
        }
        let objectKey = "\(Key.characters)_\(characterName)_\(offset)"
        try? charactersStorage?.setObject(characters, forKey: objectKey)
    }
    
    func loadCharacterComics(characterId: Int, offset: Int) -> ComicDataWrapper? {
        let objectKey = "\(Key.comics)_\(characterId)_\(offset)"
        return try? comicsStorage?.object(forKey: objectKey)
    }
    
    func saveCharacterComics(comics: ComicDataWrapper, characterId: Int, offset: Int) {
        let objectKey = "\(Key.comics)_\(characterId)_\(offset)"
        try? comicsStorage?.setObject(comics, forKey: objectKey)
    }
}
