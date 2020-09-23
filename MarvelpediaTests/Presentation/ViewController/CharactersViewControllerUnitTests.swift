//
//  CharactersViewControllerUnitTests.swift
//  MarvelpediaTests
//
//  Created by Aitor on 23/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Quick
import Nimble
import Swinject
@testable import Marvelpedia

class CharactersViewControllerUnitTests: QuickSpec {
    
    // MARK: - Mocks
    
    class MockCharactersPresenter: CharactersPresenterProtocol {
        
        var viewDidLoadIsCalled = false
        var viewWillAppearIsCalled = false
        var viewDidAppearIsCalled = false
        var viewWillDisappearIsCalled = false
        var viewDidDisappearIsCalled = false
        var bindIsCalled = false
        var loadMarvelCharactersIsCalled = false
        var searchCharactersByNameIsCalled = false
        var characterSelectedIsCalled = false
        
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
        
        func bind(view: CharactersViewControllerProtocol) {
            bindIsCalled = true
        }
        
        func loadMarvelCharacters() {
            loadMarvelCharactersIsCalled = true
        }
        
        func searchCharactersByName(name: String) {
            searchCharactersByNameIsCalled = true
        }
        
        func characterSelected(navigationController: UINavigationController, character: Character) {
            characterSelectedIsCalled = true
        }
    }
    
    // MARK: - Tests
    
    override func spec() {
        
        // MARK: Constants
        
        let container = Container()
        
        // MARK: Variables
        
        var viewController: CharactersViewController?
        var presenter: MockCharactersPresenter?
        
        // MARK: Tests
        
        beforeEach {
            container.register(CharactersViewController.self) { resolver in
                let viewController = CharactersViewController()
                viewController.presenter = resolver.resolve(MockCharactersPresenter.self)
                UINavigationController().viewControllers.append(viewController)
                return viewController
            }
            container.register(MockCharactersPresenter.self) { resolver in
                MockCharactersPresenter()
            }
            
            viewController = container.resolve(CharactersViewController.self)
            presenter = container.resolve(MockCharactersPresenter.self)
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
                    viewController?.loadView()
                    viewController?.setupView()
                }
                it("should setup navigation bar and search bar") {}
            }
        }
        describe("when displayCharacters is called") {
            context("given a valid protocol conformance and a list object") {
                beforeEach {
                    viewController?.loadView()
                    viewController?.displayCharacters([Character]())
                }
                it("should display the player list") {}
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
