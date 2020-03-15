//
//  CoutriesRoute.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

enum CountryRoute: URLRequestConvertible {
    
    static let apiUrl = "http://geodb-free-service.wirefreethought.com/v1/"
    static let itemPerPage = 10
    
    case getLang
    case getCities(lang: String, page: Int)
    
    
    var header: [String: String]{
        switch self {
        case .getLang:
            return [:]
        case .getCities:
            return [:]
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .getLang:
            return .get
        case .getCities:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getLang:
            return CountryRoute.apiUrl + "locale/languages"
        case .getCities(let lang, let page):
            let offset = page * CountryRoute.itemPerPage
            return CountryRoute.apiUrl + "geo/cities?limit=10&offset=\(offset)&languageCode=\(lang)"
        }
    }
    
    
    public func asURLRequest() throws -> URLRequest {
        
        var request = URLRequest(url: URL(string: path)!)
        
        request.allHTTPHeaderFields = header
        request.httpMethod = method.rawValue
        
        return request
    }
    
}
