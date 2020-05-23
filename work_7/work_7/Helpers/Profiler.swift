//
//  Profiler.swift
//  work_7
//
//  Created by Stanislav Belsky on 5/23/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

class Profiler {
  class func runClosureForTime(_ closure: (() -> Void)!) -> TimeInterval {
    //Timestamp before
    let startDate = Date()
    //Run the closure
    closure()
    
    //Timestamp after
    let endDate = Date()
    
    //Calculate the interval.
    let interval = endDate.timeIntervalSince(startDate)
    
    return interval
  }
}
