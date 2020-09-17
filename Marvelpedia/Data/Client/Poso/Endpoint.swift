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
    
    case characters(host: APIHost, version: APIVersion)
    case characterComics(characterId: Int, host: APIHost, version: APIVersion)
    
    // MARK: Public variables
    
    var host: String {
        switch self {
        case .characters(let host, _),
             .characterComics(_, let host, _):
            return getHostURL(host)
        }
    }
    
    var version: String {
        switch self {
        case .characters(_, let apiVersion),
             .characterComics(_, _, let apiVersion):
            return apiVersion.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .characters(_, _):
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
        case .characters(_, _),
             .characterComics(_, _, _):
            return ["apikey" : "7063ff05702d6e4f3ea7491f087b3e7c"]
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
}
