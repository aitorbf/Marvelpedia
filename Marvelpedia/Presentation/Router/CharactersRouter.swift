//
//  CharactersRouter.swift
//  Marvelpedia
//
//  Created by Aitor on 21/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit

final class CharactersRouter: BaseRouter {}

// MARK: - CharactersRouter protocol conformance

extension CharactersRouter: CharactersRouterProtocol {
    
    func goToCharacterDetail(navigationController: UINavigationController, character: Character) {
        self.navigationController = navigationController
        if let appDelegate = SceneDelegate.originalSceneDelegate {
            if let characterDetailViewController = appDelegate.dependencyInjectionManager.container.resolve(CharacterDetailViewController.self, argument: character) {
                goTo(characterDetailViewController)
            }
        }
    }
}
