//
//  SettingViewModel.swift
//  MacOS
//
//  Created by Stanislav Belsky on 6/7/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class SettingsViewModel: ObservableObject {
    
    @Published var seconds: Double
    
    var maxValue: Int = 60
    
    init() {
        seconds = Util.load(key: kTimeOutKey)  == 0 ? Double(kDefaultTime) : Double(Util.load(key: kTimeOutKey))
    }
    
    func update(){
        
        Util.save(key: kTimeOutKey, value: Int(seconds))
        
    }
    
    var didChangeValue: (Double) -> Void = { value in
 
        print("----didChangeValue", value)
    
    }
    
    var didSelectValue: (Double) -> Void = { value in
    
           print("----didSelectValue", value)
       
       }
    
    deinit {
        print("deinit", self)
    }
    
}
