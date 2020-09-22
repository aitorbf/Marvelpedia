//
//  Constants.swift
//  Marvelpedia
//
//  Created by Aitor on 17/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

enum Constants {
    
    enum API {
        enum Host {
            static let marvel = "https://gateway.marvel.com:443"
        }
        
        enum ResultLimit {
            enum marvel {
                static let characters = 100
                static let comics = 20
            }
        }
    }
}
