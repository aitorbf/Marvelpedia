//
//  CharactersPresenter.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit

final class CharactersPresenter: BasePresenter {
    
    // MARK: Private variables
    
    private var loadCharactersUseCaseInProgress = false {
        didSet {
            if loadCharactersUseCaseInProgress {
                DispatchQueue.main.async { self.view?.showLoading() }
            } else {
                DispatchQueue.main.async { self.view?.hideLoading() }
            }
        }
    }
    private var offset = 0
    private var total: Int?
    private var searchText = ""
    private var characters = [Character]()
    private var navigationController: UINavigationController? = nil
    
    // MARK: Public variables
    
    weak var view: CharactersViewControllerProtocol?
    var loadCharactersUseCase: LoadCharactersUseCaseProtocol?
    var router: CharactersRouterProtocol?
    
    // MARK: Private methods

    private func loadCharacters() {
        if total == nil || offset < total! {
            DispatchQueue.global(qos: .background).async {
                self.loadCharactersUseCaseInProgress = true
                self.loadCharactersUseCase?.execute(offset: self.offset, name: self.searchText) {
                    (response, error) in
                    self.loadCharactersUseCaseInProgress = false
                    if error != nil {
                        DispatchQueue.main.async {
                            self.view?.showError()
                        }
                    } else if let characterCollection = response {
                        DispatchQueue.main.async {
                            self.offset += characterCollection.count ?? 0
                            self.total = characterCollection.total
                            self.characters += characterCollection.characters ?? [Character]()
                            self.view?.displayCharacters(self.characters)
                        }
                    }
                }
            }
        }
    }
    
    private func loadCharactersByName(name: String) {
        total = nil
        offset = 0
        characters = [Character]()
        searchText = name
        loadCharacters()
    }
    
    private func loadCharacterDetail(character: Character) {
        if let navigationController = self.navigationController {
            self.router?.goToCharacterDetail(navigationController: navigationController, character: character)
        }
    }
}

// MARK: - CharactersPresenterProtocol protocol conformance

extension CharactersPresenter: CharactersPresenterProtocol {
    
    func viewDidLoad() {
        view?.setupView()
        loadCharacters()
    }
    
    func viewWillAppear() {
        // Do nothing
    }
    
    func viewDidAppear() {
        // Do nothing
    }
    
    func bind(view: CharactersViewControllerProtocol) {
        self.view = view
    }
    
    func loadMarvelCharacters() {
        loadCharacters()
    }
    
    func searchCharactersByName(name: String) {
        loadCharactersByName(name: name)
    }
    
    func characterSelected(navigationController: UINavigationController, character: Character) {
        self.navigationController = navigationController
        loadCharacterDetail(character: character)
    }
}
