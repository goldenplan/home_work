//
//  MovieRoute.swift
//  work_3
//
//  Created by Stanislav Belsky on 26.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Alamofire

public enum MediaType: String, Codable{
    case Multi  = "multi"
    case Movie  = "movie"
    case TV     = "tv"
    case Person = "person"
}

enum MovieRoute: URLRequestConvertible {
    
    static let apiKey = ""
    static let apiPath = "https://api.themoviedb.org/3/"
    static let imagePrefix = "https://image.tmdb.org/t/p/w300"
    
    case search(type: MediaType, query: String, page: Int)
    case genres
    case getDetails(tmdbId: Int, mediaType: MediaType)
    case credits(movieData: MovieData)
    case discover(mediaType: MediaType, page: Int)
    
    
    var header: [String: String]{
        switch self {
        case .search, .genres, .getDetails, .credits, .discover:
            return [:]
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .search, .genres, .getDetails, .credits, .discover:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .search(let type, _, _):
            return MovieRoute.apiPath + "search/\(type.rawValue)"
        case .genres:
            return MovieRoute.apiPath + "genre/movie/list"
        case .getDetails(let tmdbId, let mediaType):
            return MovieRoute.apiPath + "\(mediaType.rawValue)/\(tmdbId)"
        case .credits(let movieData):
            return MovieRoute.apiPath + "\(movieData.mediaType!.rawValue)/\(movieData.id)/credits"
        case .discover(let mediaType, _):
            return MovieRoute.apiPath + "discover/\(mediaType.rawValue)/"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .search( _, let query, let page):
            return ["api_key": MovieRoute.apiKey,
                    "query": query,
                    "page": page]
        case .genres:
            return ["api_key": MovieRoute.apiKey,
                    "language": NSLocale.preferredLanguages[0]]
        case .getDetails:
            return ["api_key": MovieRoute.apiKey,
                    "language": NSLocale.preferredLanguages[0]]
        case .credits:
            return ["api_key": MovieRoute.apiKey,
                    "language": NSLocale.preferredLanguages[0]]
        case .discover( _, let page):
            return ["api_key": MovieRoute.apiKey,
                    "page": page]
        }
    }
    
    
    public func asURLRequest() throws -> URLRequest {
        
        var request = URLRequest(url: URL(string: path)!)
        
        request.allHTTPHeaderFields = header
        request.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
    
}
