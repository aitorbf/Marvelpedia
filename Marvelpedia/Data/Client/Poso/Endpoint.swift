//
//  Endpoint.swift
//  Marvelpedia
//
//  Created by Aitor on 17/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint {
    
    // MARK: Endpoints
    
    case characters(offset: Int, name: String, host: APIHost, version: APIVersion)
    case characterComics(characterId: Int, host: APIHost, version: APIVersion)
    
    // MARK: Public variables
    
    var host: String {
        switch self {
        case .characters(_, _, let host, _),
             .characterComics(_, let host, _):
            return getHostURL(host)
        }
    }
    
    var version: String {
        switch self {
        case .characters(_, _, _, let apiVersion),
             .characterComics(_, _, let apiVersion):
            return apiVersion.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .characters(_, _, _, _):
            return "public/characters"
        case .characterComics(let characterId, _, _):
            return "public/characters/\(characterId)/comics"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default: return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .characters(let offset, let name, let host, _):
            var parameters = getParameters(host)
            parameters.updateValue(offset, forKey: "offset")
            if name != "" {
                parameters.updateValue(name, forKey: "nameStartsWith")
            }
            return parameters
        case .characterComics(_, let host, _):
            return getParameters(host)
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
        
    // MARK: Private methods
    
    private func getHostURL(_ host: APIHost) -> String {
        switch host {
        case .marvel:
            return Constants.API.Host.marvel
        }
    }
    
    private func getParameters(_ host: APIHost) -> [String : Any] {
        switch host {
        case .marvel:
            let publicMarvelAPIKey = Bundle.main.object(forInfoDictionaryKey: "PublicMarvelAPIKey") as! String
            let privateMarvelAPIKey = Bundle.main.object(forInfoDictionaryKey: "PrivateMarvelAPIKey") as! String
            let timestamp = String(Date().timeIntervalSince1970)
            let hash = (timestamp + privateMarvelAPIKey + publicMarvelAPIKey).md5()
            let parameters = [
                "ts"        : timestamp,
                "apikey"    : publicMarvelAPIKey,
                "hash"      : hash,
                "limit"     : Constants.API.ResultLimit.marvel
            ] as [String : Any]
            return parameters
        }
    }
}
