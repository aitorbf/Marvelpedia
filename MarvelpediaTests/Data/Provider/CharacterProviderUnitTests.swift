//
//  CharacterProviderUnitTests.swift
//  MarvelpediaTests
//
//  Created by Aitor on 23/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Quick
import Nimble
import Swinject
@testable import Marvelpedia

class CharacterProviderUnitTests: QuickSpec {
    
    // MARK: - Mocks
    
    class MockRemoteDataSource: RemoteDataSourceProtocol {

        var loadCharactersIsCalled = false
        var loadCharacterComicsIsCalled = false
        var isThrowing = false
        
        func loadCharacters(offset: Int, name: String, _ completion: @escaping (CharacterDataWrapper?, APIException?) -> Void) {
            loadCharactersIsCalled = true
            if isThrowing {
                completion(nil, APIException.unknownException)
            } else {
                completion(CharacterDataWrapper(), nil)
            }
        }
        
        func loadCharacterComics(characterId: Int, offset: Int, _ completion: @escaping (ComicDataWrapper?, APIException?) -> Void) {
            loadCharacterComicsIsCalled = true
            if isThrowing {
                completion(nil, APIException.unknownException)
            } else {
                completion(ComicDataWrapper(), nil)
            }
        }
    }
    
    class MockLocalDataSource: LocalDataSourceProtocol {
        
        var hasCachedData = false
        var loadCharactersIsCalled = false
        var saveCharactersIsCalled = false
        var loadCharacterComicsIsCalled = false
        var saveCharacterComicsIsCalled = false
        
        func loadCharacters(offset: Int, name: String) -> CharacterDataWrapper? {
            loadCharactersIsCalled = true
            if hasCachedData {
                return CharacterDataWrapper()
            } else {
                return nil
            }
        }
        
        func saveCharacters(characters: CharacterDataWrapper, offset: Int, name: String) {
            saveCharactersIsCalled = true
        }
        
        func loadCharacterComics(characterId: Int, offset: Int) -> ComicDataWrapper? {
            loadCharacterComicsIsCalled = true
            if hasCachedData {
                return ComicDataWrapper()
            } else {
                return nil
            }
        }
        
        func saveCharacterComics(comics: ComicDataWrapper, characterId: Int, offset: Int) {
            saveCharacterComicsIsCalled = true
        }
    }
    
    // MARK: - Tests
    
    override func spec() {
        
        // MARK: Constants
        
        let container = Container()
        
        // MARK: Variables
        
        var characterProvider: CharacterProvider?
        var remoteDataSource: MockRemoteDataSource?
        var localDataSource: MockLocalDataSource?
        
        // MARK: Tests
        
        beforeEach {
            container.register(CharacterProvider.self) { resolver in
                let characterProvider = CharacterProvider()
                characterProvider.remoteDataSource = resolver.resolve(MockRemoteDataSource.self)
                characterProvider.localDataSource = resolver.resolve(MockLocalDataSource.self)
                return characterProvider
            }
            container.register(MockRemoteDataSource.self) { resolver in
                MockRemoteDataSource()
            }
            container.register(MockLocalDataSource.self) { resolver in
                MockLocalDataSource()
            }
            
            characterProvider = container.resolve(CharacterProvider.self)
            remoteDataSource = container.resolve(MockRemoteDataSource.self)
            localDataSource = container.resolve(MockLocalDataSource.self)
        }
        describe("when loadCharacters is called") {
            context("given a valid protocol conformance, an offset and a name") {
                beforeEach {
                    characterProvider?.remoteDataSource = remoteDataSource
                    characterProvider?.localDataSource = localDataSource
                    characterProvider?.loadCharacters(offset: 0, name: "") { _,_ in }
                }
                it("should call loadCharacters localDataSource method") {
                    expect(localDataSource?.loadCharactersIsCalled).to(beTrue())
                }
                it("should call loadCharacters remoteDataSource method") {
                    expect(remoteDataSource?.loadCharactersIsCalled).to(beTrue())
                }
                it("should call saveCharacters localDataSource method") {
                    expect(localDataSource?.saveCharactersIsCalled).to(beTrue())
                }
                it("callback should be a success response") {
                    waitUntil { done in
                        remoteDataSource?.loadCharacters(offset: 0, name: "") { response, error in
                            expect(response).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        }
                    }
                }
            }
            context("given a valid protocol conformance, an offset, a name and cached data") {
                beforeEach {
                    localDataSource?.hasCachedData = true
                    characterProvider?.remoteDataSource = remoteDataSource
                    characterProvider?.localDataSource = localDataSource
                    characterProvider?.loadCharacters(offset: 0, name: "") { _,_ in }
                }
                it("should call loadCharacters localDataSource method") {
                    expect(localDataSource?.loadCharactersIsCalled).to(beTrue())
                }
                it("should call loadCharacters remoteDataSource method") {
                    expect(remoteDataSource?.loadCharactersIsCalled).to(beFalse())
                }
                it("should call saveCharacters localDataSource method") {
                    expect(localDataSource?.saveCharactersIsCalled).to(beFalse())
                }
                it("callback should be a success response") {
                    waitUntil { done in
                        remoteDataSource?.loadCharacters(offset: 0, name: "") { response, error in
                            expect(response).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        }
                    }
                }
            }
            context("given a valid protocol conformance, an offset, a name and an exception") {
                beforeEach {
                    remoteDataSource?.isThrowing = true
                    characterProvider?.remoteDataSource = remoteDataSource
                    characterProvider?.localDataSource = localDataSource
                    characterProvider?.loadCharacters(offset: 0, name: "") { _,_ in }
                }
                it("should call loadCharacters localDataSource method") {
                    expect(localDataSource?.loadCharactersIsCalled).to(beTrue())
                }
                it("should call loadCharacters remoteDataSource method") {
                    expect(remoteDataSource?.loadCharactersIsCalled).to(beTrue())
                }
                it("should call saveCharacters localDataSource method") {
                    expect(localDataSource?.saveCharactersIsCalled).to(beFalse())
                }
                it("callback should be an exception") {
                    waitUntil { done in
                        remoteDataSource?.loadCharacters(offset: 0, name: "") { response, error in
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
