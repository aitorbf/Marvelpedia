//
//  ComicMapper.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class ComicMapper {
    
    func transform(_ entity: ComicEntity) -> Comic {
        var object = Comic()
        
        object.id = entity.id
        object.title = entity.title
        object.description = entity.description
        if let path = entity.thumbnail?.path, let imageExtension = entity.thumbnail?.imageExtension {
            object.thumbnail = "\(path).\(imageExtension)"
        }
        object.pages = entity.pageCount
        if let printPrice = entity.prices?.first(where: { $0.type == "printPrice" }) {
            object.printPrice = printPrice.price
        }
        if let digitalPrice = entity.prices?.first(where: { $0.type == "digitalPrice" }) {
            object.digitalPrice = digitalPrice.price
        }
        
        return object
    }
}
