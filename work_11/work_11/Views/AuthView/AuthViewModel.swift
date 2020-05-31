//
//  AuthViewModel.swift
//  work_11
//
//  Created by Stanislav Belsky on 5/31/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

final class AuthViewModel: ObservableObject {
    
    func success(){
        print("Correct enter pincode")
        var data = ConfigData.load()
        data.isAuthorized = true
        data.save()
        Coordinator.instance.restart()
    }
    
    func fail(){
        print("Incorrect enter pincode")
        var data = ConfigData.load()
        data.isAuthorized = false
        data.save()
        Coordinator.instance.restart()
        
    }

    deinit {
        print("deinit", self)
    }
    
}
