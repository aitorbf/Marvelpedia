//
//  ComicCollectionMapper.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class ComicCollectionMapper {
    
    func transform(_ entity: ComicDataWrapper) -> ComicCollection {
        var object = ComicCollection()
        
        object.offset = entity.data?.offset
        object.total = entity.data?.total
        object.count = entity.data?.count
        object.comics = [Comic]()
        if let results = entity.data?.results {
            for result in results {
                let comic = ComicMapper().transform(result)
                object.comics?.append(comic)
            }
        }
        
        return object
    }
}
