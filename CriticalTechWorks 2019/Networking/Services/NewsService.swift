//
//  PostService.swift
//  NetworkLayer
//
//  Created by Bruno Silva on 16/11/2018.
//

import Foundation

enum NewsService: ServiceProtocol {
    
    case headlines(country: String)
    case details(locationId: String)
    
    var path: String {
        switch self {
        case .headlines:
            return "top-headlines"
        case .details:
            return "geocode.json"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
        case let .headlines(country):
            let parameters = ["country": country]
            return .requestParameters(parameters)
        case let .details(locationId):
            let parameters = ["locationid": locationId]//, "jsonattributes": 1, "gen": 9] as [String : Any]
            return .requestParameters(parameters)
        }
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
}
