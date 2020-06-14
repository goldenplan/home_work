//
//  Double.swift
//  MacOS
//
//  Created by Stanislav Belsky on 6/7/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

extension Double{
    
    func stringFromTimeInterval(_ total: Double = 3600) -> String {
        
        if self.isNaN{
            return "--"
        }
        
        let time = NSInteger(self)
        let totalTime = NSInteger(total)
        
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        //        print("totalTime", totalTime)
        if hours == 0 && totalTime < 3600{
            return String(format: "%0.2d:%0.2d",minutes,seconds)
        }else{
            return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
        }
        
    }
    
}
