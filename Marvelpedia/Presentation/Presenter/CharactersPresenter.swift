//
//  CharactersPresenter.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

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
    
    // MARK: Public variables
    
    weak var view: CharactersViewControllerProtocol?
    var loadCharactersUseCase: LoadCharactersUseCaseProtocol?
    
    // MARK: Private methods

    private func loadCharacters() {
        DispatchQueue.global(qos: .background).async {
            self.loadCharactersUseCaseInProgress = true
            self.loadCharactersUseCase?.execute() {
                (response, error) in
                self.loadCharactersUseCaseInProgress = false
                if error != nil {
                    DispatchQueue.main.async {
                        self.view?.showError()
                    }
                } else if let characterCollection = response {
                    DispatchQueue.main.async {
                        self.view?.displayCharacters(characterCollection.characters ?? [Character]())
                    }
                }
            }
        }
    }
}

// MARK: - CharactersPresenterProtocol protocol conformance

extension CharactersPresenter: CharactersPresenterProtocol {
    
    /// Tells the presenter that the view has loaded
    func viewDidLoad() {
        view?.setupView()
        loadCharacters()
    }
    
    /// Tells the presenter that the view will appear
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
}
