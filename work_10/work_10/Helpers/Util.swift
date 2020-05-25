//
//  Util.swift
//  work_10
//
//  Created by Stanislav Belsky on 5/25/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

public func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
    let dispatchTime = DispatchTime.now() + seconds
    dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
}

public enum DispatchLevel {
    case main, userInteractive, userInitiated, utility, background
    var dispatchQueue: DispatchQueue {
        switch self {
        case .main:                 return DispatchQueue.main
        case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
        case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
        case .utility:              return DispatchQueue.global(qos: .utility)
        case .background:           return DispatchQueue.global(qos: .background)
        }
    }
}

struct Util {
    
    static func dateToString(date:Date, format: String = "dd.MM.yyyy HH:mm:ss") -> String{
        
        let myDateFormatter = DateFormatter()
        //ruDateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        myDateFormatter.timeZone = NSTimeZone.system
        myDateFormatter.locale = NSLocale.current
        myDateFormatter.dateFormat = format//"dd.MM.yyyy HH:mm:ss"
        
        return myDateFormatter.string(from: date)
        
    }
    
}
