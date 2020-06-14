//
//  MenuViewModel.swift
//  MacOS
//
//  Created by Stanislav Belsky on 6/7/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class MenuViewModel: ObservableObject {
    
    @Published var isHidden = false
    
    @Published var selectedView: Int?
    
    init() {
        
        
        
    }
    
    
    
    deinit {
        print("deinit", self)
    }
    
}
