//
//  RealmService.swift
//  work_6
//
//  Created by Stanislav Belsky on 28.04.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import RealmSwift

class RealmStack {
    
    static let instance = RealmStack()
    
    var realm: Realm? = nil
    
    init() {
        
//        do {
//            try FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
//        } catch {}
        
        let config = Realm.Configuration(
            
            shouldCompactOnLaunch: { totalBytes, usedBytes in
                
                let oneHundredMB = 100 * 1024 * 1024
                return (totalBytes > oneHundredMB) && (Double(usedBytes) / Double(totalBytes)) < 0.5
            },
            
            objectTypes: [RealmMovie.self]
            
        )

        do {
            realm = try Realm(configuration: config)
        } catch let e {
            print("Error init realm: \(e)")
        }
        
    }
    
    
}
