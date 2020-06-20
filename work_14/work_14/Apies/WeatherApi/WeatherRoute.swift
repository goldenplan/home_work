//
//  WeatherRoute.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

enum WeatherRoute: URLRequestConvertible {
    
    static let apiKey = "9ea1249a6e7bb85fe5a7bdaaa184820e"// Enter key
    static let apiUrl = "http://api.openweathermap.org/data/2.5/"
    
    case getWeather(longitude: Double, latitude: Double)
    
    
    var header: [String: String]{
        switch self {
        case .getWeather:
            return [:]
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getWeather(let longitude, let latitude):
            return WeatherRoute.apiUrl + "weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(WeatherRoute.apiKey)"
        }
    }
    
    
    public func asURLRequest() throws -> URLRequest {
        
        var request = URLRequest(url: URL(string: path)!)
        
        request.allHTTPHeaderFields = header
        request.httpMethod = method.rawValue
        
        return request
    }
    
}
