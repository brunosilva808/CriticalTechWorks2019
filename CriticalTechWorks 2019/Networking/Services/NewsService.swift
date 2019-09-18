//
//  PostService.swift
//  NetworkLayer
//
//  Created by Bruno Silva on 16/11/2018.
//

import Foundation

enum NewsService: ServiceProtocol {
    
    case headlines(countryCode: String)
    
    var path: String {
        switch self {
        case .headlines:
            return "top-headlines"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
        case let .headlines(countryCode):
            let parameters = ["country": countryCode]
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
