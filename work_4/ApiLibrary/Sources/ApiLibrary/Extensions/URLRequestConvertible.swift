//
//  File.swift
//  
//
//  Created by Stanislav Belsky on 01.04.2020.
//

import Foundation

public protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}
