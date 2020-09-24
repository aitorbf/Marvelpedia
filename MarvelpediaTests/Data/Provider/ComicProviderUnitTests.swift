//
//  ComicProviderUnitTests.swift
//  MarvelpediaTests
//
//  Created by Aitor on 23/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Quick
import Nimble
import Swinject
@testable import Marvelpedia

class ComicProviderUnitTests: QuickSpec {
    
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
        
        var comicProvider: ComicProvider?
        var remoteDataSource: MockRemoteDataSource?
        var localDataSource: MockLocalDataSource?
        
        // MARK: Tests
        
        beforeEach {
            container.register(ComicProvider.self) { resolver in
                let comicProvider = ComicProvider()
                comicProvider.remoteDataSource = resolver.resolve(MockRemoteDataSource.self)
                comicProvider.localDataSource = resolver.resolve(MockLocalDataSource.self)
                return comicProvider
            }
            container.register(MockRemoteDataSource.self) { resolver in
                MockRemoteDataSource()
            }
            container.register(MockLocalDataSource.self) { resolver in
                MockLocalDataSource()
            }
            
            comicProvider = container.resolve(ComicProvider.self)
            remoteDataSource = container.resolve(MockRemoteDataSource.self)
            localDataSource = container.resolve(MockLocalDataSource.self)
        }
        describe("when loadCharacterComics is called") {
            context("given a valid protocol conformance, a character id and offset") {
                beforeEach {
                    comicProvider?.remoteDataSource = remoteDataSource
                    comicProvider?.localDataSource = localDataSource
                    comicProvider?.loadCharacterComics(characterId: 123456789, offset: 0) { _,_ in }
                }
                it("should call loadCharacterComics localDataSource method") {
                    expect(localDataSource?.loadCharacterComicsIsCalled).to(beTrue())
                }
                it("should call loadCharacterComics remoteDataSource method") {
                    expect(remoteDataSource?.loadCharacterComicsIsCalled).to(beTrue())
                }
                it("should call saveCharacterComics localDataSource method") {
                    expect(localDataSource?.saveCharacterComicsIsCalled).to(beTrue())
                }
                it("callback should be a success response") {
                    waitUntil { done in
                        remoteDataSource?.loadCharacterComics(characterId: 123456789, offset: 0) { response, error in
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
                    comicProvider?.remoteDataSource = remoteDataSource
                    comicProvider?.localDataSource = localDataSource
                    comicProvider?.loadCharacterComics(characterId: 123456789, offset: 0) { _,_ in }
                }
                it("should call loadCharacterComics localDataSource method") {
                    expect(localDataSource?.loadCharacterComicsIsCalled).to(beTrue())
                }
                it("should call loadCharacterComics remoteDataSource method") {
                    expect(remoteDataSource?.loadCharacterComicsIsCalled).to(beFalse())
                }
                it("should call saveCharacterComics localDataSource method") {
                    expect(localDataSource?.saveCharacterComicsIsCalled).to(beFalse())
                }
                it("callback should be a success response") {
                    waitUntil { done in
                        remoteDataSource?.loadCharacterComics(characterId: 123456789, offset: 0) { response, error in
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
                    comicProvider?.remoteDataSource = remoteDataSource
                    comicProvider?.localDataSource = localDataSource
                    comicProvider?.loadCharacterComics(characterId: 123456789, offset: 0) { _,_ in }
                }
                it("should call loadCharacterComics localDataSource method") {
                    expect(localDataSource?.loadCharacterComicsIsCalled).to(beTrue())
                }
                it("should call loadCharacterComics remoteDataSource method") {
                    expect(remoteDataSource?.loadCharacterComicsIsCalled).to(beTrue())
                }
                it("should call saveCharacterComics localDataSource method") {
                    expect(localDataSource?.saveCharacterComicsIsCalled).to(beFalse())
                }
                it("callback should be a success response") {
                    waitUntil { done in
                        remoteDataSource?.loadCharacterComics(characterId: 123456789, offset: 0) { response, error in
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
