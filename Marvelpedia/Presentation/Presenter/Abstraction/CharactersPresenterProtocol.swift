//
//  CharactersPresenterProtocol.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit

protocol CharactersPresenterProtocol: BasePresenterProtocol {
    
    func bind(view: CharactersViewControllerProtocol)
    
    func loadMarvelCharacters()
    
    func searchCharactersByName(name: String)
    
    func characterSelected(navigationController: UINavigationController,
                            character: Character)
}
