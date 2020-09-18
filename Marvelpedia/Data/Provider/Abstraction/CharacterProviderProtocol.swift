//
//  CharactersProviderProtocol.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

protocol CharacterProviderProtocol {
    
    func loadCharacters(_ completion: @escaping (_ response: CharacterCollection?, _ error: APIException?) -> Void)
}
