//
//  ConfigViewModel.swift
//  work_11
//
//  Created by Stanislav Belsky on 5/30/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class ConfigViewModel: ObservableObject {
    
    @Published var configData: ConfigData
    
    init() {
        configData = ConfigData.load()
    }
    
    func save(){
        configData.save()
    }
    
    func restart() {
        save()
        Coordinator.instance.restart()
    }
    
    func reset() {
        let data = ConfigData()
        data.save()
        Coordinator.instance.restart()
    }
    
    deinit {
        print("deinit", self)
    }
    
}


