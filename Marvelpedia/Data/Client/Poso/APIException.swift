//
//  APIException.swift
//  Marvelpedia
//
//  Created by Aitor on 17/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

enum APIException: Error {
    
    case parametersErrorException
    case invalidRefererOrHashException
    case methodNotAllowedException
    case forbiddenException
    case cacheException
    case unknownException
}
