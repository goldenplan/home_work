//
//  TestViewModel.swift
//  work_10
//
//  Created by Stanislav Belsky on 5/25/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class TestViewModel: ObservableObject {
    
    @Published var taskList: [TaskDescription] = []
    
    init() {
        
        setupNotification()
        
        runOnStart()
        
    }
    
    func runOnStart(){
        
        let firstOperation = FirstOperation(settings: OperationSettings(isNeedIndicating: true))
        
        OperationManager.instance.add(firstOperation)
        
        let secondOperation = SecondOperation(settings: OperationSettings(isNeedIndicating: true))
        
        OperationManager.instance.add(secondOperation)
        
    }
    
    func runFirstTask(){
        let firstOperation = FirstOperation(settings: OperationSettings(isNeedIndicating: true))
        
        OperationManager.instance.add(firstOperation)
    }
    
    func runSecondTask(){
        let secondOperation = SecondOperation(settings: OperationSettings(isNeedIndicating: true))
        
        OperationManager.instance.add(secondOperation)
    }
    
    @objc func addStartedTask(_ notification: Notification){
        if let userInfo = notification.userInfo as NSDictionary?,
            let type = userInfo["type"] as? String,
            let name = userInfo["name"] as? String,
            let startTime = userInfo["startTime"] as? Double{
            
            print("start", type, name, startTime)
            
            let task = TaskDescription(type: type, name: name, startTime: startTime, progress: 0, remaningTime: 0)
            
            DispatchQueue.main.async{
                self.taskList.insert(task, at: 0)
            }
            
        }
    }
    
    @objc func updateProgressTask(_ notification: Notification){
        
        if let userInfo = notification.userInfo as NSDictionary?,
            let type = userInfo["type"] as? String,
            let name = userInfo["name"] as? String,
            let startTime = userInfo["startTime"] as? Double,
            let progress = userInfo["progress"] as? Double{
            
            print("progress", type, name, startTime, progress)
            
            if let index = taskList.firstIndex(where: { (item) -> Bool in
                return item.name == name
            }){
                DispatchQueue.main.async{
                    self.taskList[index].progress = progress
                }
            }else{
                let task = TaskDescription(type: type, name: name, startTime: startTime, progress: progress, remaningTime: 0)
                
                DispatchQueue.main.async{
                    self.taskList.insert(task, at: 0)
                }
                
            }
            
        }
    }
    

    @objc func markFinishedTask(_ notification: Notification){
        
        if let userInfo = notification.userInfo as NSDictionary?,
            let type = userInfo["type"] as? String,
            let name = userInfo["name"] as? String,
            let startTime = userInfo["startTime"] as? Double,
            let progress = userInfo["progress"] as? Double,
            let remaningTime = userInfo["remaningTime"] as? Double{
            
            print("end", type, name, startTime, progress, remaningTime)
            
            if let index = taskList.firstIndex(where: { (item) -> Bool in
                return item.name == name
            }){
                DispatchQueue.main.async{
                    self.taskList[index].progress = progress
                    self.taskList[index].remaningTime = remaningTime
                }
            }else{
                let task = TaskDescription(type: type, name: name, startTime: startTime, progress: progress, remaningTime: remaningTime)
                DispatchQueue.main.async{
                    self.taskList.insert(task, at: 0)
                }
            }
            
        }
    }
    
    func setupNotification(){
    
        NotificationCenter.default.addObserver(self, selector: #selector(addStartedTask(_:)), name: Notification.Name.OperationManager.Start, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(markFinishedTask(_:)), name: Notification.Name.OperationManager.Stop, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateProgressTask(_:)), name: Notification.Name.OperationManager.Progress, object: nil)
    }
    
    func removeNotification(){
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    deinit {
        removeNotification()
        print("deinit", self)
    }
    
}


