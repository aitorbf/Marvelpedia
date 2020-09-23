//
//  CharacterDetailViewControllerUnitTests.swift
//  MarvelpediaTests
//
//  Created by Aitor on 23/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Quick
import Nimble
import Swinject
@testable import Marvelpedia

class CharacterDetailViewControllerUnitTests: QuickSpec {
    
    // MARK: - Mocks
    
    class MockCharacterDetailPresenter: CharacterDetailPresenterProtocol {
        
        var viewDidLoadIsCalled = false
        var viewWillAppearIsCalled = false
        var viewDidAppearIsCalled = false
        var viewWillDisappearIsCalled = false
        var viewDidDisappearIsCalled = false
        var bindIsCalled = false
        var loadCharacterComicsIsCalled = false
        
        func viewDidLoad() {
            viewDidLoadIsCalled = true
        }
        
        func viewWillAppear() {
            viewWillAppearIsCalled = true
        }
        
        func viewDidAppear() {
            viewDidAppearIsCalled = true
        }
        
        func viewWillDisappear() {
            viewWillDisappearIsCalled = true
        }
        
        func viewDidDisappear() {
            viewDidDisappearIsCalled = true
        }
        
        func bind(view: CharacterDetailViewControllerProtocol) {
            bindIsCalled = true
        }
        
        func loadCharacterComics(characterId: Int) {
            loadCharacterComicsIsCalled = true
        }
    }
    
    // MARK: - Tests
    
    override func spec() {
        
        // MARK: Constants
        
        let container = Container()
        
        // MARK: Variables
        
        var viewController: CharacterDetailViewController?
        var presenter: MockCharacterDetailPresenter?
        
        // MARK: Tests
        
        beforeEach {
            container.register(CharacterDetailViewController.self) { resolver in
                var character = Character()
                character.id = 123456789
                let viewController = CharacterDetailViewController(character: character)
                viewController.presenter = resolver.resolve(MockCharacterDetailPresenter.self)
                UINavigationController().viewControllers.append(viewController)
                return viewController
            }
            container.register(MockCharacterDetailPresenter.self) { resolver in
                MockCharacterDetailPresenter()
            }
            
            viewController = container.resolve(CharacterDetailViewController.self)
            presenter = container.resolve(MockCharacterDetailPresenter.self)
        }
        describe("when viewDidLoad is called") {
            context("given a valid presenter") {
                beforeEach {
                    viewController?.presenter = presenter
                    viewController?.viewDidLoad()
                }
                it("should call bind presenter method") {
                    expect(presenter?.bindIsCalled).to(beTrue())
                }
                it("should call viewDidLoad presenter method") {
                    expect(presenter?.viewDidLoadIsCalled).to(beTrue())
                }
            }
        }
        describe("when viewWillAppear is called") {
            context("given a valid presenter") {
                beforeEach {
                    viewController?.presenter = presenter
                    viewController?.viewWillAppear(false)
                }
                it("should call viewWillAppear presenter method") {
                    expect(presenter?.viewWillAppearIsCalled).to(beTrue())
                }
            }
        }
        describe("when viewDidAppear is called") {
            context("given a valid presenter") {
                beforeEach {
                    viewController?.presenter = presenter
                    viewController?.viewDidAppear(false)
                }
                it("should call viewDidAppear presenter method") {
                    expect(presenter?.viewDidAppearIsCalled).to(beTrue())
                }
            }
        }
        describe("when viewDidDisappear is called") {
            context("given a valid presenter") {
                beforeEach {
                    viewController?.presenter = presenter
                    viewController?.viewDidDisappear(false)
                }
                it("should call viewDidDisappear presenter method") {
                    expect(presenter?.viewDidDisappearIsCalled).to(beTrue())
                }
            }
        }
        describe("when setupView is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    viewController?.presenter = presenter
                    viewController?.setupView()
                }
                it("should call loadCharacterComics presenter method") {
                    expect(presenter?.loadCharacterComicsIsCalled).to(beTrue())
                }
                it("should setup navigation bar") {}
            }
        }
        describe("when displayComics is called") {
            context("given a valid protocol conformance and a list object") {
                beforeEach {
                    viewController?.presenter = presenter
                    viewController?.loadView()
                    viewController?.displayComics([Comic]())
                }
                it("should display the comic list") {}
            }
        }
        describe("when showLoading is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    viewController?.loadView()
                    viewController?.showLoading()
                }
                it("should show the loading view") {}
            }
        }
        describe("when hideLoading is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    viewController?.loadView()
                    viewController?.showLoading()
                    viewController?.hideLoading()
                }
                it("should hide the loading view") {}
            }
        }
        describe("when showError is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    viewController?.loadView()
                    viewController?.showError()
                }
                it("should display an error alert") {}
            }
        }
    }
}
