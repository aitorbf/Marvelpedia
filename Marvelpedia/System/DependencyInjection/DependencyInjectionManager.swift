//
//  DependencyInjectionManager.swift
//  Marvelpedia
//
//  Created by Aitor on 19/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Swinject

class DependencyInjectionManager {
    
    // MARK: - Constants
    
    let container = Container()
    
    // MARK: - Initializers
    
    init() {
        registerViewControllers()
        registerPresenters()
        registerUseCases()
        registerProviders()
        registerDataSources()
        registerClients()
    }
    
    // MARK: - Private functions
    
    private func registerViewControllers() {
        container.register(CharactersViewController.self) { resolver in
            let viewController = CharactersViewController()
            viewController.presenter = resolver.resolve(CharactersPresenterProtocol.self)
            return viewController
        }
    }
    
    private func registerPresenters() {
        container.register(CharactersPresenterProtocol.self) { resolver in
            let presenter = CharactersPresenter()
            presenter.loadCharactersUseCase = resolver.resolve(LoadCharactersUseCaseProtocol.self)
            return presenter
        }
    }
    
    private func registerUseCases() {
        container.register(LoadCharactersUseCaseProtocol.self) { resolver in
            let useCase = LoadCharactersUseCase()
            useCase.networkProvider = resolver.resolve(NetworkProviderProtocol.self)
            useCase.characterProvider = resolver.resolve(CharacterProviderProtocol.self)
            return useCase
        }
        container.register(LoadCharacterComicsUseCaseProtocol.self) { resolver in
            let useCase = LoadCharacterComicsUseCase()
            useCase.networkProvider = resolver.resolve(NetworkProviderProtocol.self)
            useCase.comicProvider = resolver.resolve(ComicProviderProtocol.self)
            return useCase
        }
    }
    
    private func registerProviders() {
        container.register(NetworkProviderProtocol.self) { resolver in
            return NetworkProvider()
        }
        container.register(CharacterProviderProtocol.self) { resolver in
            let provider = CharacterProvider()
            provider.remoteDataSource = resolver.resolve(RemoteDataSourceProtocol.self)
            return provider
        }
        container.register(ComicProviderProtocol.self) { resolver in
            let provider = ComicProvider()
            provider.remoteDataSource = resolver.resolve(RemoteDataSourceProtocol.self)
            return provider
        }
    }
    
    private func registerDataSources() {
        container.register(RemoteDataSourceProtocol.self) { resolver in
            let dataSource = RemoteDataSource()
            dataSource.marvelClient = resolver.resolve(MarvelClientProtocol.self)
            return dataSource
        }
    }
    
    private func registerClients() {
        container.register(MarvelClientProtocol.self) { resolver in
            return MarvelClient()
        }.inObjectScope(.container)
    }
}
