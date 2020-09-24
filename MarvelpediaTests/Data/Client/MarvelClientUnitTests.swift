//
//  MarvelClientUnitTests.swift
//  MarvelpediaTests
//
//  Created by Aitor on 23/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Quick
import Nimble
import Swinject
@testable import Marvelpedia

class MarvelClientUnitTests: QuickSpec {
    
    // MARK: - Tests
    
    override func spec() {
        
        // MARK: Constants
        
        let container = Container()
        
        // MARK: Variables
        
        var marvelClient: MarvelClient?
        
        // MARK: Tests
        
        beforeEach {
            container.register(MarvelClient.self) { resolver in
                MarvelClient()
            }
            
            marvelClient = container.resolve(MarvelClient.self)
        }
        describe("when loadCharacters is called") {
            context("given a valid protocol conformance, an offset and an empty name") {
                beforeEach {
                    marvelClient?.loadCharacters(offset: 0, name: ""){_,_ in }
                }
                it("should perform the network call") {}
            }
            context("given a valid protocol conformance, an offset and an valid name") {
                beforeEach {
                    marvelClient?.loadCharacters(offset: 0, name: "iron"){_,_ in }
                }
                it("should perform the network call") {}
            }
        }
        describe("when loadCharacterComics is called") {
            context("given a valid protocol conformance, a valid character id and an offset") {
                beforeEach {
                    marvelClient?.loadCharacterComics(characterId: 123456789, offset: 0) {_,_ in }
                }
                it("should perform the network call") {}
            }
        }
    }
}
