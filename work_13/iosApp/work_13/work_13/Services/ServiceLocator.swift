//
//  ServiceLocator.swift
//  work_13
//
//  Created by Stanislav Belsky on 6/14/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

protocol ServiceLocator {
    func getService<T>() -> T
}

final class MovieServiceLocator: ServiceLocator {

    private var registry : [String: Any] = [:]
    
    func registerService<T>(service: T) {
        let key = "\(T.self)"
        registry[key] = service
    }
    
    func tryGetService<T>() -> T? {
        let key = "\(T.self)"
        return registry[key] as? T
    }
    
    func getService<T>() -> T {
        let key = "\(T.self)"
        return registry[key] as! T
    }

}
