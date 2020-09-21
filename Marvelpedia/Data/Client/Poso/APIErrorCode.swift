//
//  APIErrorCode.swift
//  Marvelpedia
//
//  Created by Aitor on 17/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

enum APIErrorCode: String {
    
    case missingApiKeyOrHashOrTimestamp     = "409"
    case invalidRefererOrHash               = "401"
    case methodNotAllowed                   = "405"
    case forbidden                          = "403"
}
