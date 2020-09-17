//
//  CharacterEntity.swift
//  Marvelpedia
//
//  Created by Aitor on 16/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class CharacterEntity: Codable {
    
    // MARK: Public constants
    
    let id: Int?
    let name: String?
    let description: String?
    let modified: Date?
    let resourceURI: String?
    let urls: [Url]?
    let thumbnail: Image?
    let comics: ComicList?
    let stories: StoryList?
    let events: EventList?
    let series: SeriesList?
    
    // MARK: Initializers
    
    init() {
        id = nil
        name = nil
        description = nil
        modified = nil
        resourceURI = nil
        urls = nil
        thumbnail = nil
        comics = nil
        stories = nil
        events = nil
        series = nil
    }
}
