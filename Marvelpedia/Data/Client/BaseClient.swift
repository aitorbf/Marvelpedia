//
//  BaseClient.swift
//  Marvelpedia
//
//  Created by Aitor on 17/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation
import Alamofire

class BaseClient {
    
    // MARK: Private constants
    
    private let semaphore = Semaphore()
    
    // MARK: Public methods
    
    func request(_ endpoint: Endpoint, attempt: Int = 0,
                 maxNumberOfTries: Int = 3, delayTimeBetweenTries: UInt32 = 3, _ completion: @escaping (_ response: APIResponse?, _ error: APIException?) -> Void) {
        
    let url = "\(endpoint.host)/\(endpoint.version)/\(endpoint.path)"
    
    AF.request(url,
        method: endpoint.method,
        parameters: endpoint.parameters,
        encoding: endpoint.encoding,
        headers: nil)
        .validate().responseData(completionHandler: { response in
            switch response.result {
            case .success:
                completion(APIResponse(data: response.data), nil)
            case .failure:
                // Check if the code is executed from a test target
                if let _ = NSClassFromString("XCTest") {
                    completion(nil, APIException.unknownException)
                }
                
                if let data = response.error {
//                    do {
//                        if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                            if let code = dictionary["errorCode"] as? String {
//                                completion(nil, self.checkErrorCode(code))
//                            }
//                        }
//                    } catch let exception {
//                        completion(nil, exception as? APIException)
//                    }
                    print(data)
                }
                completion(nil, APIException.connectivityException)
            }
        })
    }
    
    // MARK: - Private methods
    
    private func checkErrorCode(_ errorCode: String) -> APIException {
           if let validErrorCode = APIErrorCode(rawValue: errorCode) {
               switch validErrorCode {
               case .missingApiKeyOrHashOrTimestamp:
                   return .missingApiKeyOrHashOrTimestampException
               case .invalidRefererOrHash:
                   return .invalidRefererOrHashException
               case .methodNotAllowed:
                   return .methodNotAllowedException
               case .forbidden:
                   return .forbiddenException
               }
           }
           return .connectivityException
       }
}
