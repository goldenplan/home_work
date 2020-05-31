//
//  Notification.swift
//  work_10
//
//  Created by Stanislav Belsky on 5/25/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    public struct OperationManager {
        
        public static let Tick = Notification.Name(rawValue: "work_10.operation_manager.tick")
        
        public static let Start = Notification.Name(rawValue: "work_10.operation_manager.start")
        
        public static let Stop = Notification.Name(rawValue: "work_10.operation_manager.stop")
        
        public static let Progress = Notification.Name(rawValue: "work_10.operation_manager.progress")
        
    }

}
