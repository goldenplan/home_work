//
//  GameViewModel.swift
//  MacOS
//
//  Created by Stanislav Belsky on 6/7/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class GameViewModel: ObservableObject {
    
    @Published var currentDate = Date()
    
    @Published var remainingTime: Double = 0
    
    var timer: Publishers.Autoconnect<Timer.TimerPublisher>!
    
    var store: Set<AnyCancellable> = []
    
    @Published var count: Int = 0
    
    init() {
        print("init", self)
    }
    
    func startGame(){
        
        count = 0
        remainingTime = Double(Util.load(key: kTimeOutKey))
        
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        timer.sink { [weak self] (item) in
            
            guard let strongSelf = self else { return }
            
            strongSelf.remainingTime = strongSelf.remainingTime - 1
            
            if strongSelf.remainingTime == 0{
                strongSelf.stopGame()
            }
            
        }.store(in: &store)
        
    }
    
    func stopGame(){
        
        saveResultIfNeed()
        
        store.forEach { (item) in
            item.cancel()
        }
        
    }
    
    func increase(){
        count = count + 1
    }
    
    func saveResultIfNeed(){
        
        guard count > 0 else { return }
        
        let currentTimeLimit: Int = Util.load(key: kTimeOutKey)
        
        let currentResults: [String: Int] = Util.load(key: kResultKey)
        
        if let currentBestResult = currentResults["\(currentTimeLimit)"],
            currentBestResult > count{
            print("Skip save")
        }else{
            Util.add(key: kResultKey, value: [currentTimeLimit : count])
        }
        
    }
    
    deinit {
        print("deinit", self)
    }
    
}


