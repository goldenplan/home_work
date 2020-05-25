//
//  SecondOperation.swift
//  work_10
//
//  Created by Stanislav Belsky on 5/25/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

class SecondOperation: MyOperation {
    
    let semaphore = DispatchSemaphore(value: 0)
    
    override func job(){
        
        setState(newState: .Executing)
        
        let times = 20
        
        for i in 0...times{
            sleep(1)
            progress = Double(i) / Double(times)
            
        }
        
        setState(newState: .Finished)
        
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        
        var newSettings = settings
        newSettings.name = String(Date().timeIntervalSince1970)
        newSettings.startDate = Date()
        newSettings.isDelayedStart = false
        
        var depsCopyes = [MyOperation]()
        depOperations.forEach { (item) in
            let newDep = item.copy()
            depsCopyes.append(newDep as! MyOperation)
        }
        
        let copy = SecondOperation(settings: newSettings, depOperations: depsCopyes)
        return copy
    }
    
    deinit {
        print("deinit", self.description)
    }
    
}
