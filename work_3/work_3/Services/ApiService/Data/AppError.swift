//
//  ApiError.swift
//  work_3
//
//  Created by Stanislav Belsky on 26.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

struct ErrorsData: Codable {
    let errors:  [String]
}

struct ErrorData: Codable {
    let statusCode:  Int
    let statusMessage : String
    let success: Bool
}

enum AppError: Error, LocalizedError {
    case apiErrors([String])
    case apiError(ErrorData)
    case urlError(URLError)
    case responseError(Int)
    case decodingError(DecodingError)
    case genericError
}
