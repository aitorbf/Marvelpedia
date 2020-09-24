//
//  LoadCharactersUseCaseUnitTests.swift
//  MarvelpediaTests
//
//  Created by Aitor on 23/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Quick
import Nimble
import Swinject
@testable import Marvelpedia

class LoadCharactersUseCaseUnitTest: QuickSpec {
    
    // MARK: - Mocks
    
    class MockCharacterProvider: CharacterProviderProtocol {
        var loadCharactersIsCalled = false
        var isThrowing = false
        
        func loadCharacters(offset: Int, name: String, _ completion: @escaping (CharacterCollection?, APIException?) -> Void) {
            loadCharactersIsCalled = true
            if isThrowing {
                completion(nil, APIException.unknownException)
            } else {
                completion(CharacterCollection(), nil)
            }
        }
    }
    
    // MARK: - Tests
    
    override func spec() {
        
        // MARK: Constants
        
        let container = Container()
        
        // MARK: Variables
        
        var useCase: LoadCharactersUseCase?
        var characterProvider: MockCharacterProvider?
        
        // MARK: Tests
        
        beforeEach {
            container.register(LoadCharactersUseCase.self) { resolver in
                let useCase = LoadCharactersUseCase()
                useCase.characterProvider = resolver.resolve(MockCharacterProvider.self)
                return useCase
            }
            container.register(MockCharacterProvider.self) { resolver in
                MockCharacterProvider()
            }
            
            useCase = container.resolve(LoadCharactersUseCase.self)
            characterProvider = container.resolve(MockCharacterProvider.self)
        }
        describe("when execute is called") {
            context("given a valid protocol conformance and a valid response from character provider") {
                beforeEach {
                    useCase?.characterProvider = characterProvider
                    useCase?.execute(offset: 0, name: "") { _,_ in }
                }
                it("should call loadCharacters characterProvider method") {
                    expect(characterProvider?.loadCharactersIsCalled).to(beTrue())
                }
                it("callback should be a success response") {
                    waitUntil { done in
                        characterProvider?.loadCharacters(offset: 0, name: "") { response, error in
                            expect(response).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        }
                    }
                }
            }
            context("given a valid protocol conformance and an error response from character provider") {
                beforeEach {
                    characterProvider?.isThrowing = true
                    useCase?.characterProvider = characterProvider
                    useCase?.execute(offset: 0, name: "") { _,_ in }
                }
                it("should call loadCharacters characterProvider method") {
                    expect(characterProvider?.loadCharactersIsCalled).to(beTrue())
                }
                it("callback should be an exception") {
                    waitUntil { done in
                        characterProvider?.loadCharacters(offset: 0, name: "") { response, error in
                            expect(response).to(beNil())
                            expect(error).notTo(beNil())
                            done()
                        }
                    }
                }
            }
        }
    }
}
