//
//  LoadCharacterComicsUseCaseProtocol.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

protocol LoadCharacterComicsUseCaseProtocol {
    
    func execute(characterId: Int, offset: Int, _ completion: @escaping (_ response: ComicCollection?, _ error: APIException?) -> Void)
}
