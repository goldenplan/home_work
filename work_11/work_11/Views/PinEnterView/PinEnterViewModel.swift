//
//  PinEnterViewModel.swift
//  work_11
//
//  Created by Stanislav Belsky on 5/31/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class PinEnterViewModel: ObservableObject {
    
    var completion: (Result<Bool, Error>)->()
    
    init(completion: @escaping (Result<Bool, Error>)->()) {
        self.completion = completion
    }
    
    func success(){
        print("Correct enter pincode")
        completion(Result.success(true))
    }
    
    func fail(){
        print("Incorrect enter pincode")
        completion(Result.success(false))
    }

    deinit {
        print("deinit", self)
    }
    
}


