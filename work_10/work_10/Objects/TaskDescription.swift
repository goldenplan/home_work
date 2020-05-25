//
//  TaskDescription.swift
//  work_10
//
//  Created by Stanislav Belsky on 5/25/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

struct TaskDescription: Identifiable {
    var id:String {
        name
    }
    
    let type            : String
    let name            : String
    var startTime       : Double
    var progress        : Double
    var remaningTime    : Double
    
    var startDate       : Date{
        Date(timeIntervalSince1970: startTime)
    }
    
}
