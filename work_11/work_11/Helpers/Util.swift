//
//  Util.swift
//  work_11
//
//  Created by Stanislav Belsky on 5/31/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

class Util {
    
    static func startSleep(randomizeTime: Bool = true) {
        Thread.sleep(forTimeInterval: randomizeTime ? Double(Int.random(in: 1...3)) : 1.0)

    }
    
}
