//
//  ApiError.swift
//  work_3
//
//  Created by Stanislav Belsky on 26.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

public struct ErrorsData: Codable {
    let errors:  [String]
}

public struct ErrorData: Codable {
    let statusCode:  Int
    let statusMessage : String
    let success: Bool
}

public enum ApiError: Error, LocalizedError {
    case cacheError(String)
    case apiErrors([String])
    case apiError(ErrorData)
    case urlError(URLError)
    case responseError(Int)
    case decodingError(DecodingError)
    case genericError
}
