//
//  OperationManager.swift
//  work_10
//
//  Created by Stanislav Belsky on 5/25/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

class OperationManager: NSObject{
    
    var isActiveApp: Bool = false
    
    struct Constants {
        static let maxDuration: TimeInterval = 300
        static let memoryLimit:UInt64 = 1_000_000_000
    }
    
    static let instance = OperationManager()
    
    private var timer: Timer!
    
    private let operationQueue = OperationQueue()
    
    private var operationStore = [MyOperation]()
    
    var isNeedIndicating: Bool{
        get{
            return (operationQueue.operations as! [MyOperation]).filter({ (item) -> Bool in
                return item.settings.isNeedIndicating && !item.isFinished
            }).count > 0
        }
    }
    
    override init() {
        super.init()
        operationQueue.qualityOfService = .utility
        operationQueue.maxConcurrentOperationCount = 4
        startTimer()
        
        delay(bySeconds: 2) {
            self.addOnStart()
        }
        
    }
    
    func addOnStart(){
        

        
        
        
    }
    
    func forceStart(_ operation: MyOperation){
        cancelAll()
        
        operationStore.insert(operation, at: 0)
    }
    
    func add(_ operation: MyOperation){
        
        operationStore.append(operation)
    }
    
    func remove(by operationClass: MyOperation.Type){
        
        operationStore.removeAll { (item) -> Bool in
            return operationClass.description() == item.classForCoder.description()
        }
        
        cancel(by: operationClass)
        
    }
    
    func cancel(by operationClass: MyOperation.Type){
        
        operationQueue.operations.forEach { (item) in
            
            func finishDeps(deps: [MyOperation]){
                
                deps.forEach({ (depItem) in
                    
                    print("dep:", depItem.description, depItem.state)
                    
                    depItem.setState(newState: .Canceled)
                    
                    if depItem.dependencies.count > 0 {
                        finishDeps(deps: depItem.dependencies as! [MyOperation])
                    }
                    
                })
                
            }
            
            print(item.classForCoder.description())
            
            if operationClass.description() == item.classForCoder.description(){
                
                print("Найдена", operationClass.description(), "dependencies", item.dependencies)
                
                if item.dependencies.count > 0{
                    finishDeps(deps: item.dependencies as! [MyOperation])
                }
                
                (item as! MyOperation).setState(newState: .Canceled)
            }
        }
        
    }
    
    func checkStoreAndRun(){
        
//        if operationQueue.operations.count != 0 {return}
        
        if let operationForRun = operationStore.first(where: { (item) -> Bool in
            
            if item.settings.periodTime == nil && item.settings.startDate < Date(){
                return true
            }else if item.settings.periodTime != nil && (Date().timeIntervalSince1970 - item.settings.startDate.timeIntervalSince1970 > item.settings.periodTime! || item.settings.startDate == Date(timeIntervalSince1970: 0)){
                return true
            }
            
            return false
            
        }){
            moveInQueue(operationForRun)
        }
        
    }
    
    private func moveInQueue(_ operation: MyOperation){
        
        var operations = [MyOperation]()
        
        func addDep(oper: MyOperation, deps: [MyOperation]){
            
            deps.forEach { (dep) in
                oper.addDependency(dep)
                operations.append(dep)
                if dep.depOperations.count > 0 {
                    addDep(oper: dep, deps: dep.depOperations)
                }
            }
            
            if !operations.contains(oper){
                operations.append(oper)
            }
            
        }
        
        operationStore.removeAll { (item) -> Bool in
            return item.settings.name == operation.settings.name
        }
        
        if operation.settings.periodTime != nil{
            let operationCopy = operation.copy()
            add(operationCopy as! MyOperation)
        }
        
        addDep(oper: operation, deps: operation.depOperations)
        
        if !operation.settings.isDelayedStart{
            operationQueue.addOperations(operations, waitUntilFinished: false)
        }
        
    }
    
    func clearStore(){
        operationStore.removeAll()
    }
    
    func cancelAll(){
        operationQueue.cancelAllOperations()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func UpdateTimer() {
//        print("UpdateTimer")
        operationQueue.operations.forEach { (operation) in
            print(operation.description, "in queue", (operation as! MyOperation).state)
        }
        
        checkStoreAndRun()
    }
    
}

