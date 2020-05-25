//
//  MyOperation.swift
//  work_10
//
//  Created by Stanislav Belsky on 5/25/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

enum OperationState {
    case Executing
    case Canceled
    case Finished
    case None
}

class MyOperation: Operation, NSCopying {
    
    var settings: OperationSettings
    
    var data: Any?
    
    var depOperations: [MyOperation]
    
    var indicatorRunning = false
    
    var state: OperationState = .None{
        didSet{
            print(name!, "state set", state)
        }
    }
    
    var remaningTime: TimeInterval{
        return Date().timeIntervalSince1970 - startTime
    }
    
    var startTime: TimeInterval!
    
    var progress: Double = 0{
        didSet{
            print(name!, "progress", progress)
            notifiOnProgress(progress)
        }
    }
    
    override var isExecuting: Bool{
        return state == .Executing
    }
    
    override var isCancelled: Bool{
        return state == .Canceled
    }
    
    override var isFinished: Bool{
        return state == .Finished
    }
    
    init(settings: OperationSettings, data: Any? = nil, depOperations: [MyOperation] = []) {
        
        self.settings = settings
        
        self.depOperations = depOperations
        
        self.data = data
        
        super.init()
        
        self.name = settings.name
        
        self.qualityOfService = .utility
    }
    
    override func main() {
        super.main()
        
    }
    
    override func start(){
        
        if state == .None{
            job()
        }
        
    }
    
    func job(){
        
        setState(newState: .Executing)
        
        for i in 1...10{
            
            if isCancelled || isFinished{ return }
            
            sleep(1)
            
            if isCancelled || isFinished { return }
            
            progress = Double(i)
            
        }
        
        setState(newState: .Finished)
        
    }
    
    func setState(newState: OperationState){
        
//        print("-", state, newState)
        
        switch (state, newState) {
        case (.None, .Executing):
            state = newState
            startTime = Date().timeIntervalSince1970
            notifiOnStart()
        case (.Executing, .Canceled):
            state = newState
            setState(newState: .Finished)
        case (.Canceled, .Finished):
            state = newState
            notifiOnFinishIfNeed()
            finish()
        case (.None, .Canceled):
            state = newState
            setState(newState: .Finished)
        case (.Executing, .Finished):
            state = newState
            notifiOnFinishIfNeed()
            finish()
        default:
            break
        }
        
    }
    
    override func cancel() {
        super.cancel()
        setState(newState: .Canceled)
    }
    
    func finish(){
        print("Finish")
        if startTime != nil{
            print("runnigTime is", Date().timeIntervalSince1970 - startTime)
        }
        
    }
    
    
    func copy(with zone: NSZone? = nil) -> Any {
        
        var newSettings = settings
        newSettings.name = String(Date().timeIntervalSince1970)
        newSettings.startDate = Date()
        
        var depsCopyes = [MyOperation]()
        depOperations.forEach { (item) in
            let newDep = item.copy()
            depsCopyes.append(newDep as! MyOperation)
        }
        
        let copy = MyOperation(settings: newSettings, depOperations: depsCopyes)
        return copy
    }
    
    func notifiOnStart(){
        if !settings.isNeedIndicating { return }
        
        indicatorRunning = true
            
        NotificationCenter.default.post(
            name: NSNotification.Name.OperationManager.Start,
            object: nil,
            userInfo: [
                "type"          : classForCoder.description(),
                "name"          : settings.name!,
                "startTime"     : startTime ?? 0.0
        ])

    }
    
    func notifiOnFinishIfNeed(){
        
        if !settings.isNeedIndicating || !indicatorRunning{ return }
        
        indicatorRunning = false
            
        NotificationCenter.default.post(
            name: NSNotification.Name.OperationManager.Stop,
            object: nil,
            userInfo: [
                "type"          : classForCoder.description(),
                "name"          : settings.name!,
                "startTime"     : startTime ?? 0.0,
                "progress"      : progress,
                "remaningTime"  : remaningTime
        ])
        
    }
    
    func notifiOnProgress(_ progress: Double){
        
        if !settings.isNeedIndicating { return }
            
        NotificationCenter.default.post(name: NSNotification.Name.OperationManager.Progress, object: nil, userInfo: [
            "type"          : classForCoder.description(),
            "name"          : settings.name!,
            "startTime"     : startTime ?? 0,
            "progress"      : progress
            ])
        
    }
    
}


