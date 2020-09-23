//
//  CharactersPresenterUnitTests.swift
//  MarvelpediaTests
//
//  Created by Aitor on 23/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Quick
import Nimble
import Swinject
@testable import Marvelpedia

class CharactersPresenterUnitTests: QuickSpec {
    
    // MARK: - Mocks
    
    class MockCharactersViewController: CharactersViewControllerProtocol {
        var displayCharactersIsCalled = false
        var showLoadingIsCalled = false
        var hideLoadingIsCalled = false
        var showErrorIsCalled = false
        var setupViewIsCalled = false
        
        func displayCharacters(_ list: [Character]) {
            displayCharactersIsCalled = true
        }
        
        func showLoading() {
            showLoadingIsCalled = true
        }
        
        func hideLoading() {
            hideLoadingIsCalled = true
        }
        
        func showError() {
            showErrorIsCalled = true
        }
        
        func setupView() {
            setupViewIsCalled = true
        }
    }
    
    class MockLoadCharactersUseCase: LoadCharactersUseCaseProtocol {
        
        var executeIsCalled = false
        var isThrowing = false
        
        func execute(offset: Int, name: String, _ completion: @escaping (CharacterCollection?, APIException?) -> Void) {
            executeIsCalled = true
            if isThrowing {
                completion(nil, APIException.unknownException)
            } else {
                completion(CharacterCollection(), nil)
            }
        }
    }
    
    class MockCharactersRouter: CharactersRouterProtocol {
        var goToCharacterDetailIsCalled = false
        
        func goToCharacterDetail(navigationController: UINavigationController, character: Character) {
            goToCharacterDetailIsCalled = true
        }
    }
    
    // MARK: - Tests
    
    override func spec() {
        
        // MARK: Constants
        
        let container = Container()
        
        // MARK: Variables
        
        var viewController: MockCharactersViewController?
        var presenter: CharactersPresenter?
        var loadCharactersUseCase: MockLoadCharactersUseCase?
        var router: MockCharactersRouter?
        
        // MARK: Tests
        
        beforeEach {
            container.register(CharactersPresenter.self) { resolver in
                let presenter = CharactersPresenter()
                presenter.view = resolver.resolve(MockCharactersViewController.self)
                presenter.loadCharactersUseCase = resolver.resolve(MockLoadCharactersUseCase.self)
                presenter.router = resolver.resolve(MockCharactersRouter.self)
                return presenter
            }
            container.register(MockCharactersViewController.self) { resolver in
                MockCharactersViewController()
            }
            container.register(MockLoadCharactersUseCase.self) { resolver in
                MockLoadCharactersUseCase()
            }
            container.register(MockCharactersRouter.self) { resolver in
                MockCharactersRouter()
            }
            
            viewController = container.resolve(MockCharactersViewController.self)
            presenter = container.resolve(CharactersPresenter.self)
            loadCharactersUseCase = container.resolve(MockLoadCharactersUseCase.self)
            router = container.resolve(MockCharactersRouter.self)
        }
        describe("when viewDidLoad is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    presenter?.loadCharactersUseCase = loadCharactersUseCase
                    presenter?.viewDidLoad()
                }
                it("should call setup viewController method") {
                    expect(viewController?.setupViewIsCalled).to(beTrue())
                }
                it("should call execute loadCharactersUseCase method") {
                    expect(loadCharactersUseCase?.executeIsCalled).toEventually(beTrue())
                }
            }
        }
        describe("when viewWillAppear is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    presenter?.viewWillAppear()
                }
                it("should do nothing") {}
            }
        }
        describe("when viewDidAppear is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    presenter?.viewDidAppear()
                }
                it("should do nothing") {}
            }
        }
        describe("when viewWillDisappear is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    presenter?.viewWillDisappear()
                }
                it("should do nothing") {}
            }
        }
        describe("when viewDidDisappear is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    presenter?.viewDidDisappear()
                }
                it("should do nothing") {}
            }
        }
        describe("when bind is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                }
                it("should bind the view with the presenter") {
                    expect(presenter?.view).to(beAKindOf(CharactersViewControllerProtocol.self))
                }
            }
        }
        describe("when loadMarvelCharacters is called") {
            context("given a valid protocol conformance and a correct use case response") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    presenter?.loadCharactersUseCase = loadCharactersUseCase
                    presenter?.loadMarvelCharacters()
                }
                it("should call execute loadCharactersUseCase method") {
                    expect(loadCharactersUseCase?.executeIsCalled).toEventually(beTrue())
                }
                it("should call displayCharacters viewController method") {
                    expect(viewController?.displayCharactersIsCalled).toEventually(beTrue())
                }
            }
            context("given a valid protocol conformance and an exception use case call") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    loadCharactersUseCase?.isThrowing = true
                    presenter?.loadCharactersUseCase = loadCharactersUseCase
                    presenter?.loadMarvelCharacters()
                }
                it("should call execute loadCharactersUseCase method") {
                    expect(loadCharactersUseCase?.executeIsCalled).toEventually(beTrue())
                }
                it("callback should be an exception") {
                    waitUntil { done in
                        loadCharactersUseCase?.execute(offset: 0, name: "") { response, error in
                            expect(response).to(beNil())
                            expect(error).notTo(beNil())
                            done()
                        }
                    }
                }
                it("should call showError viewController method") {
                    expect(viewController?.showErrorIsCalled).toEventually(beTrue())
                }
            }
        }
        describe("when searchCharactersByName is called") {
            context("given a valid protocol conformance and a correct use case response") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    presenter?.loadCharactersUseCase = loadCharactersUseCase
                    presenter?.searchCharactersByName(name: "")
                }
                it("should call execute loadCharactersUseCase method") {
                    expect(loadCharactersUseCase?.executeIsCalled).toEventually(beTrue())
                }
                it("should call displayCharacters viewController method") {
                    expect(viewController?.displayCharactersIsCalled).toEventually(beTrue())
                }
            }
            context("given a valid protocol conformance and an exception use case call") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    loadCharactersUseCase?.isThrowing = true
                    presenter?.loadCharactersUseCase = loadCharactersUseCase
                    presenter?.searchCharactersByName(name: "")
                }
                it("should call execute loadCharactersUseCase method") {
                    expect(loadCharactersUseCase?.executeIsCalled).toEventually(beTrue())
                }
                it("callback should be an exception") {
                    waitUntil { done in
                        loadCharactersUseCase?.execute(offset: 0, name: "") { response, error in
                            expect(response).to(beNil())
                            expect(error).notTo(beNil())
                            done()
                        }
                    }
                }
                it("should call showError viewController method") {
                    expect(viewController?.showErrorIsCalled).toEventually(beTrue())
                }
            }
        }
        describe("when characterSelected is called") {
            context("given a valid protocol conformance and a correct use case response") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    presenter?.router = router
                    presenter?.characterSelected(navigationController: UINavigationController(rootViewController: UIViewController(nibName: "CharactersViewController", bundle: nil)), character: Character())
                }
                it("should call goToCharacterDetail router method") {
                    expect(router?.goToCharacterDetailIsCalled).toEventually(beTrue())
                }
            }
        }
    }
}
