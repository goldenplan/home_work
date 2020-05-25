//
//  OperationSettings.swift
//  work_10
//
//  Created by Stanislav Belsky on 5/25/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

struct OperationSettings {
    var startDate: Date
    var maxDuration: TimeInterval
    var periodTime: TimeInterval?
    var name: String!
    var isNeedIndicating: Bool = false
    var isDelayedStart: Bool = false
    
    init() {
        self.name = String(Date().timeIntervalSince1970)
        self.startDate = Date(timeIntervalSince1970: 0)
        self.maxDuration = OperationManager.Constants.maxDuration
        self.periodTime = nil
        self.isNeedIndicating = false
        self.isDelayedStart = false
    }
    
    init(
        startDate: Date = Date(timeIntervalSince1970: 0),
        maxDuration: TimeInterval = OperationManager.Constants.maxDuration,
        periodTime: TimeInterval? = nil,
        isNeedIndicating: Bool = false,
        isDelayedStart: Bool = false) {
        
        self.name = String(Date().timeIntervalSince1970)
        self.startDate = startDate
        self.maxDuration = maxDuration
        self.periodTime = periodTime
        self.isNeedIndicating = isNeedIndicating
        self.isDelayedStart = isDelayedStart
        
    }
}


