//
//  MarvelClientProtocol.swift
//  Marvelpedia
//
//  Created by Aitor on 17/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

protocol MarvelClientProtocol {
    
    func loadCharacters(_ completion: @escaping (_ response: CharacterDataWrapper?, _ error: APIException?) -> Void)
    
    func loadCharacterComics(characterId: Int, _ completion: @escaping (_ response: ComicDataWrapper?, _ error: APIException?) -> Void)
}
