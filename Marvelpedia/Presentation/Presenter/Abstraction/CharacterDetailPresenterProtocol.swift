//
//  CharacterDetailPresenterProtocol.swift
//  Marvelpedia
//
//  Created by Aitor on 21/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

protocol CharacterDetailPresenterProtocol: BasePresenterProtocol {
    
    func bind(view: CharacterDetailViewControllerProtocol)
    
    func loadCharacterComics(characterId: Int)
}
