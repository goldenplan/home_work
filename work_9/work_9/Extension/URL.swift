//
//  URL.swift
//  work_9
//
//  Created by Stanislav Belsky on 5/24/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

extension URL{
    
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
    
}
