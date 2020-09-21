//
//  EventList.swift
//  Marvelpedia
//
//  Created by Aitor on 16/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class EventList: Codable {
    
    // MARK: Public constants
    
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [EventSummary]?
    
    // MARK: Initializers
    
    init() {
        available = nil
        returned = nil
        collectionURI = nil
        items = nil
    }
}
