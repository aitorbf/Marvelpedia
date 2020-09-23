//
//  LoadCharacterComicsUseCaseUnitTests.swift
//  MarvelpediaTests
//
//  Created by Aitor on 23/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Quick
import Nimble
import Swinject
@testable import Marvelpedia

class LoadCharacterComicsUseCaseUnitTest: QuickSpec {
    
    // MARK: - Mocks
    
    class MockComicProvider: ComicProviderProtocol {
        var loadCharacterComicsIsCalled = false
        var isThrowing = false
        
        func loadCharacterComics(characterId: Int, offset: Int, _ completion: @escaping (ComicCollection?, APIException?) -> Void) {
            loadCharacterComicsIsCalled = true
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
        
        var useCase: LoadCharacterComicsUseCase?
        var comicProvider: MockComicProvider?
        
        // MARK: Tests
        
        beforeEach {
            container.register(LoadCharacterComicsUseCase.self) { resolver in
                let useCase = LoadCharacterComicsUseCase()
                useCase.comicProvider = resolver.resolve(MockComicProvider.self)
                return useCase
            }
            container.register(MockComicProvider.self) { resolver in
                MockComicProvider()
            }
            
            useCase = container.resolve(LoadCharacterComicsUseCase.self)
            comicProvider = container.resolve(MockComicProvider.self)
        }
        describe("when execute is called") {
            context("given a valid protocol conformance and a valid response from comic provider") {
                beforeEach {
                    useCase?.comicProvider = comicProvider
                    useCase?.execute(characterId: 123456789, offset: 0) { _,_ in }
                }
                it("should call loadCharacterComics comicProvider method") {
                    expect(comicProvider?.loadCharacterComicsIsCalled).to(beTrue())
                }
                it("callback should be a success response") {
                    waitUntil { done in
                        comicProvider?.loadCharacterComics(characterId: 123456789, offset: 0) { response, error in
                            expect(response).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        }
                    }
                }
            }
            context("given a valid protocol conformance and an error response from comic provider") {
                beforeEach {
                    comicProvider?.isThrowing = true
                    useCase?.comicProvider = comicProvider
                    useCase?.execute(characterId: 123456789, offset: 0) { _,_ in }
                }
                it("should call loadCharacterComics comicProvider method") {
                    expect(comicProvider?.loadCharacterComicsIsCalled).to(beTrue())
                }
                it("callback should be an exception") {
                    waitUntil { done in
                        comicProvider?.loadCharacterComics(characterId: 123456789, offset: 0) { response, error in
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
