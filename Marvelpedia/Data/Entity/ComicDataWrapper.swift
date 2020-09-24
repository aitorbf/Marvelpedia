//
//  ComicDataWrapper.swift
//  Marvelpedia
//
//  Created by Aitor on 16/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class ComicDataWrapper: Codable {
    
    // MARK: Public constants
    
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: ComicDataContainer?
    let eTag: String?
    
    // MARK: Initializers
    
    init() {
        code = nil
        status = nil
        copyright = nil
        attributionText = nil
        attributionHTML = nil
        data = nil
        eTag = nil
    }
}
