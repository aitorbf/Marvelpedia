//
//  CharacterDetailPresenterUnitTests.swift
//  MarvelpediaTests
//
//  Created by Aitor on 23/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Quick
import Nimble
import Swinject
@testable import Marvelpedia

class CharacterDetailPresenterUnitTests: QuickSpec {
    
    // MARK: - Mocks
    
    class MockCharacterDetailViewController: CharacterDetailViewControllerProtocol {
        var displayComicsIsCalled = false
        var showLoadingIsCalled = false
        var hideLoadingIsCalled = false
        var showErrorIsCalled = false
        var setupViewIsCalled = false
        
        func displayComics(_ list: [Comic]) {
            displayComicsIsCalled = true
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
    
    class MockLoadCharacterComicsUseCase: LoadCharacterComicsUseCaseProtocol {
        
        var executeIsCalled = false
        var isThrowing = false
        
        func execute(characterId: Int, offset: Int, _ completion: @escaping (ComicCollection?, APIException?) -> Void) {
            executeIsCalled = true
            if isThrowing {
                completion(nil, APIException.unknownException)
            } else {
                completion(ComicCollection(), nil)
            }
        }
    }
    
    // MARK: - Tests
    
    override func spec() {
        
        // MARK: Constants
        
        let container = Container()
        
        // MARK: Variables
        
        var viewController: MockCharacterDetailViewController?
        var presenter: CharacterDetailPresenter?
        var loadCharacterComicsUseCase: MockLoadCharacterComicsUseCase?
        
        // MARK: Tests
        
        beforeEach {
            container.register(CharacterDetailPresenter.self) { resolver in
                let presenter = CharacterDetailPresenter()
                presenter.view = resolver.resolve(MockCharacterDetailViewController.self)
                presenter.loadCharacterComicsUseCase = resolver.resolve(MockLoadCharacterComicsUseCase.self)
                return presenter
            }
            container.register(MockCharacterDetailViewController.self) { resolver in
                MockCharacterDetailViewController()
            }
            container.register(MockLoadCharacterComicsUseCase.self) { resolver in
                MockLoadCharacterComicsUseCase()
            }
            
            viewController = container.resolve(MockCharacterDetailViewController.self)
            presenter = container.resolve(CharacterDetailPresenter.self)
            loadCharacterComicsUseCase = container.resolve(MockLoadCharacterComicsUseCase.self)
        }
        describe("when viewDidLoad is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    presenter?.loadCharacterComicsUseCase = loadCharacterComicsUseCase
                    presenter?.viewDidLoad()
                }
                it("should call setup viewController method") {
                    expect(viewController?.setupViewIsCalled).to(beTrue())
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
                    expect(presenter?.view).to(beAKindOf(CharacterDetailViewControllerProtocol.self))
                }
            }
        }
        describe("when loadCharacterComics is called") {
            context("given a valid protocol conformance and a correct use case response") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    presenter?.loadCharacterComicsUseCase = loadCharacterComicsUseCase
                    presenter?.loadCharacterComics(characterId: 123456789)
                }
                it("should call execute loadCharacterComicsUseCase method") {
                    expect(loadCharacterComicsUseCase?.executeIsCalled).toEventually(beTrue())
                }
                it("should call displayComics viewController method") {
                    expect(viewController?.displayComicsIsCalled).toEventually(beTrue())
                }
            }
            context("given a valid protocol conformance and an exception use case call") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    loadCharacterComicsUseCase?.isThrowing = true
                    presenter?.loadCharacterComicsUseCase = loadCharacterComicsUseCase
                    presenter?.loadCharacterComics(characterId: 123456789)
                }
                it("should call execute loadCharacterComicsUseCase method") {
                    expect(loadCharacterComicsUseCase?.executeIsCalled).toEventually(beTrue())
                }
                it("callback should be an exception") {
                    waitUntil { done in
                        loadCharacterComicsUseCase?.execute(characterId: 123456789, offset: 0) { response, error in
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
    }
}
