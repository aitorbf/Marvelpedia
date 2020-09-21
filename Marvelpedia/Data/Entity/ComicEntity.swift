//
//  ComicEntity.swift
//  Marvelpedia
//
//  Created by Aitor on 16/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class ComicEntity: Codable {
    
    // MARK: Public constants
    
    let id: Int?
    let digitalId: Int?
    let title: String?
    let issueNumber: Double?
    let variantDescription: String?
    let description: String?
    let modified: String?
    let isbn: String?
    let upc: String?
    let diamondCode: String?
    let ean: String?
    let issn: String?
    let format: String?
    let pageCount: Int?
    let textObjects: [TextObject]?
    let resourceURI: String?
    let urls: [Url]?
    let series: SeriesSummary?
    let variants: [ComicSummary]?
    let collections: [ComicSummary]?
    let collectedIssues: [ComicSummary]?
    let dates: [ComicDate]?
    let prices: [ComicPrice]?
    let thumbnail: Image?
    let images: [Image]?
    let creators: CreatorList?
    let characters: CharacterList?
    let stories: StoryList?
    let events: EventList?
    
    // MARK: Initializers
    
    init() {
        id = nil
        digitalId = nil
        title = nil
        issueNumber = nil
        variantDescription = nil
        description = nil
        modified = nil
        isbn = nil
        upc = nil
        diamondCode = nil
        ean = nil
        issn = nil
        format = nil
        pageCount = nil
        textObjects = nil
        resourceURI = nil
        urls = nil
        series = nil
        variants = nil
        collections = nil
        collectedIssues = nil
        dates = nil
        prices = nil
        thumbnail = nil
        images = nil
        creators = nil
        characters = nil
        stories = nil
        events = nil
    }
}
