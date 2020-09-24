//
//  SeriesList.swift
//  Marvelpedia
//
//  Created by Aitor on 16/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class SeriesList: Codable {
    
    // MARK: Public constants
    
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [SeriesSummary]?
    
    // MARK: Initializers
    
    init() {
        available = nil
        returned = nil
        collectionURI = nil
        items = nil
    }
}
