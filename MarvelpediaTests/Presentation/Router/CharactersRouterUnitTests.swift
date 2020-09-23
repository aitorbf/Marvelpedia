//
//  CharactersRouterUnitTests.swift
//  MarvelpediaTests
//
//  Created by Aitor on 23/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Quick
import Nimble
import Swinject
@testable import Marvelpedia

class CharactersRouterUnitTests: QuickSpec {
    
    // MARK: - Tests
    
    override func spec() {
        
        // MARK: Constants
        
        let container = Container()
        
        // MARK: Variables
        
        var router: CharactersRouter?
        
        // MARK: Tests
        
        beforeEach {
            container.register(CharactersRouter.self) { resolver in
                CharactersRouter()
            }
            
            router = container.resolve(CharactersRouter.self)
        }
        describe("when goToCharacterDetail is called") {
            context("given a valid protocol conformance and a valid character object") {
                beforeEach {
                    var character = Character()
                    character.id = 123456789
                    router?.goToCharacterDetail(navigationController: UINavigationController(rootViewController: UIViewController(nibName: "CharacterDetailViewController", bundle: nil)), character: character)
                }
                it("should assign a valid value to navigation controller") {
                    expect(router?.navigationController).toNot(beNil())
                }
            }
        }
    }
}
