//
//  Util.swift
//  work_9
//
//  Created by Stanislav Belsky on 5/24/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

struct Util {
    
    static func dateFromString(string:String, format:String)->Date?{
        
        let tempFormatter = DateFormatter()
        tempFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0000") as TimeZone?
        tempFormatter.locale = NSLocale.current
        tempFormatter.dateFormat = format
        let tempDate = tempFormatter.date(from: string)!
        
        return tempDate
        
    }
    
}
