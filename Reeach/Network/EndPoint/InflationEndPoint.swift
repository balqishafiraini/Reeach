//
//  InflationEndPoint.swift
//  Reeach
//
//  Created by James Christian Wira on 13/10/22.
//

import Foundation

public enum InflationAPI {
    case getInflation
}

extension InflationAPI: EndPointType {
    var baseUrl: String {
        return "api.worldbank.org"
//        return "https://api.worldbank.org"
//        return "jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self {
        case .getInflation:
            return "/v2/country/id/indicator/FP.CPI.TOTL.ZG?format=json"
//            return "/posts"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getInflation:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type":"application/json"]
    }
    
}
