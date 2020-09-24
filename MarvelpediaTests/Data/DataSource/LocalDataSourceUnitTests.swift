//
//  LocalDataSourceUnitTests.swift
//  MarvelpediaTests
//
//  Created by Aitor on 23/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Quick
import Nimble
import Swinject
@testable import Marvelpedia

class LocalDataSourceUnitTests: QuickSpec {
    
    // MARK: - Tests
    
    override func spec() {
        
        // MARK: Constants
        
        let container = Container()
        
        // MARK: Variables
        
        var dataSource: LocalDataSource?
        
        // MARK: Tests
        
        beforeEach {
            container.register(LocalDataSource.self) { resolver in
                return LocalDataSource()
            }
            
            dataSource = container.resolve(LocalDataSource.self)
        }
        describe("when loadCharacters is called") {
            context("given a valid protocol conformance, an offset and an empty name") {
                beforeEach {
                    _ = try? dataSource?.loadCharacters(offset: 0, name: "")
                }
                it("should gives a CharacterDataWrapper object or nil") {}
            }
            context("given a valid protocol conformance, an offset and a name") {
                beforeEach {
                    _ = try? dataSource?.loadCharacters(offset: 0, name: "iron")
                }
                it("should gives a CharacterDataWrapper object or nil") {}
            }
        }
        describe("when saveCharacters is called") {
            context("given a valid protocol conformance, characters, an offset and an empty name") {
                beforeEach {
                    dataSource?.saveCharacters(characters: CharacterDataWrapper(), offset: 0, name: "")
                }
                it("should save characters on cache") {}
            }
            context("given a valid protocol conformance, characters, an offset and a name") {
                beforeEach {
                    dataSource?.saveCharacters(characters: CharacterDataWrapper(), offset: 0, name: "iron")
                }
                it("should save characters on cache") {}
            }
        }
        describe("when loadCharacterComics is called") {
            context("given a valid protocol conformance, a character id and an offset") {
                beforeEach {
                    _ = try? dataSource?.loadCharacterComics(characterId: 123456789, offset: 0)
                }
                it("should gives a ComicDataWrapper object or nil") {}
            }
        }
        describe("when saveCharacterComics is called") {
            context("given a valid protocol conformance, comics, a character id and an offset") {
                beforeEach {
                    dataSource?.saveCharacterComics(comics: ComicDataWrapper(), characterId: 123456789, offset: 0)
                }
                it("should save comics on cache") {}
            }
        }
    }
}
