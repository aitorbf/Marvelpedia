//
//  APIException.swift
//  Marvelpedia
//
//  Created by Aitor on 17/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

enum APIException: Error {
    
    case connectivityException
    case missingApiKeyOrHashOrTimestampException
    case invalidRefererOrHashException
    case methodNotAllowedException
    case forbiddenException
    case unknownException
}
