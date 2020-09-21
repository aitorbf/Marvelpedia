//
//  BaseUseCase.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class BaseUseCase {
    
    // MARK: Public variables
    
    var networkProvider: NetworkProviderProtocol?
    
    // MARK: Public methods
    
    func checkInternetConnection() throws {
        guard let hasInternetConnection = networkProvider?.hasInternetConnection() else {
            throw APIException.connectivityException
        }
        if !hasInternetConnection { throw APIException.connectivityException }
    }
}
