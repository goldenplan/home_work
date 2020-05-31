//
//  ConfigData.swift
//  work_11
//
//  Created by Stanislav Belsky on 5/30/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct ConfigData: Codable {
    
    var isAuthorized: Bool = true
    var isNeedPinEnter: Bool = false
    var startViewType: ViewTypes = .HomeViewType
    
    func save() {
        CacheManager.save(data: self, fileType: .Config)
    }
    
    static func load() -> ConfigData{
        if let data: ConfigData = CacheManager.load(fileType: .Config){
            return data
        }
        return ConfigData()
    }
    
    
    
}
