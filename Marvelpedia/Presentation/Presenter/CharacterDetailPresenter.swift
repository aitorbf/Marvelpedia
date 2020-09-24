//
//  CharacterDetailPresenter.swift
//  Marvelpedia
//
//  Created by Aitor on 21/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

final class CharacterDetailPresenter: BasePresenter {
    
    // MARK: Private variables
    
    private var loadCharacterComicsUseCaseInProgress = false {
        didSet {
            if loadCharacterComicsUseCaseInProgress {
                DispatchQueue.main.async { self.view?.showLoading() }
            } else {
                DispatchQueue.main.async { self.view?.hideLoading() }
            }
        }
    }
    private var offset = 0
    private var total: Int?
    private var characterComics = [Comic]()
    
    // MARK: Public variables
    
    weak var view: CharacterDetailViewControllerProtocol?
    var loadCharacterComicsUseCase: LoadCharacterComicsUseCaseProtocol?
    
    // MARK: Private methods

    private func loadComics(characterId: Int) {
        if total == nil || offset < total! {
            DispatchQueue.global(qos: .background).async {
                self.loadCharacterComicsUseCaseInProgress = true
                self.loadCharacterComicsUseCase?.execute(characterId: characterId, offset: self.offset) {
                    (response, error) in
                    self.loadCharacterComicsUseCaseInProgress = false
                    if error != nil {
                        DispatchQueue.main.async {
                            self.view?.showError()
                        }
                    } else if let comicCollection = response {
                        DispatchQueue.main.async {
                            self.offset += comicCollection.count ?? 0
                            self.total = comicCollection.total
                            self.characterComics += comicCollection.comics ?? [Comic]()
                            self.view?.displayComics(self.characterComics)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - CharactersPresenterProtocol protocol conformance

extension CharacterDetailPresenter: CharacterDetailPresenterProtocol {
    
    func viewDidLoad() {
        view?.setupView()
    }
    
    func viewWillAppear() {
        // Do nothing
    }
    
    func viewDidAppear() {
        // Do nothing
    }
    
    func bind(view: CharacterDetailViewControllerProtocol) {
        self.view = view
    }
    
    func loadCharacterComics(characterId: Int) {
        loadComics(characterId: characterId)
    }
}
