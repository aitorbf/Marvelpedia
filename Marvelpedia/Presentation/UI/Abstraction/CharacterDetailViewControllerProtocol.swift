//
//  CharacterDetailViewControllerProtocol.swift
//  Marvelpedia
//
//  Created by Aitor on 21/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

protocol CharacterDetailViewControllerProtocol: BaseViewControllerProtocol {
    
    func displayComics(_ list: [Comic])
    
    func showLoading()
    
    func hideLoading()
    
    func showError()
}
