//
//  NetworkProvider.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

protocol NetworkProviderProtocol {
    
    func hasInternetConnection() -> Bool
}
