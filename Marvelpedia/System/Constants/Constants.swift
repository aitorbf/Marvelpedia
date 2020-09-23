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
            static let marvel = 100
        }
    }
    
    enum Error {
        static let title = "Error"
        static let message = "There was an internal error, please try again later"
        static let buttonAccept = "Accept"
    }
}
