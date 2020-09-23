//
//  RemoteDataSourceUnitTests.swift
//  MarvelpediaTests
//
//  Created by Aitor on 23/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Quick
import Nimble
import Swinject
@testable import Marvelpedia

class RemoteDataSourceUnitTests: QuickSpec {
    
    // MARK: - Mocks
    
    class MockMarvelClient: MarvelClientProtocol {

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
    
    // MARK: - Tests
    
    override func spec() {
        
        // MARK: Constants
        
        let container = Container()
        
        // MARK: Variables
        
        var dataSource: RemoteDataSource?
        var marvelClient: MockMarvelClient?
        
        // MARK: Tests
        
        beforeEach {
            container.register(RemoteDataSource.self) { resolver in
                let dataSource = RemoteDataSource()
                dataSource.marvelClient = resolver.resolve(MockMarvelClient.self)
                return dataSource
            }
            container.register(MockMarvelClient.self) { resolver in
                MockMarvelClient()
            }
            
            dataSource = container.resolve(RemoteDataSource.self)
            marvelClient = container.resolve(MockMarvelClient.self)
        }
        describe("when loadCharacters is called") {
            context("given a valid protocol conformance, an offset and a name") {
                beforeEach {
                    dataSource?.marvelClient = marvelClient
                    dataSource?.loadCharacters(offset: 0, name: "") { _,_ in }
                }
                it("should call loadCharacters marvelClient method") {
                    expect(marvelClient?.loadCharactersIsCalled).to(beTrue())
                }
                it("callback should be a success response") {
                    waitUntil { done in
                        marvelClient?.loadCharacters(offset: 0, name: "") { response, error in
                            expect(response).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        }
                    }
                }
            }
            context("given a valid protocol conformance, an offset, a name and an exception") {
                beforeEach {
                    marvelClient?.isThrowing = true
                    dataSource?.marvelClient = marvelClient
                    dataSource?.loadCharacters(offset: 0, name: "") { _,_ in }
                }
                it("should call loadCharacters marvelClient method") {
                    expect(marvelClient?.loadCharactersIsCalled).to(beTrue())
                }
                it("callback should be an exception") {
                    waitUntil { done in
                        marvelClient?.loadCharacters(offset: 0, name: "") { response, error in
                            expect(response).to(beNil())
                            expect(error).notTo(beNil())
                            done()
                        }
                    }
                }
            }
        }
        describe("when loadCharacterComics is called") {
            context("given a valid protocol conformance, a character id and an offset") {
                beforeEach {
                    dataSource?.marvelClient = marvelClient
                    dataSource?.loadCharacterComics(characterId: 123456789, offset: 0) { _,_ in }
                }
                it("should call loadCharacterComics marvelClient method") {
                    expect(marvelClient?.loadCharacterComicsIsCalled).to(beTrue())
                }
                it("callback should be a success response") {
                    waitUntil { done in
                        marvelClient?.loadCharacterComics(characterId: 123456789, offset: 0) { response, error in
                            expect(response).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        }
                    }
                }
            }
            context("given a valid protocol conformance, a character id, an offset and an exception") {
                beforeEach {
                    marvelClient?.isThrowing = true
                    dataSource?.marvelClient = marvelClient
                    dataSource?.loadCharacterComics(characterId: 123456789, offset: 0) { _,_ in }
                }
                it("should call loadCharacterComics marvelClient method") {
                    expect(marvelClient?.loadCharacterComicsIsCalled).to(beTrue())
                }
                it("callback should be an exception") {
                    waitUntil { done in
                        marvelClient?.loadCharacterComics(characterId: 123456789, offset: 0) { response, error in
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
