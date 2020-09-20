//
//  CharactersViewControllerProtocol.swift
//  Marvelpedia
//
//  Created by Aitor on 19/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

protocol CharactersViewControllerProtocol: BaseViewControllerProtocol {
    
    func displayCharacters(_ list: [Character])
    
    func showLoading()
    
    func hideLoading()
    
    func showError()
}
