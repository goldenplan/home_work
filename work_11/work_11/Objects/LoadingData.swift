//
//  StartData.swift
//  work_11
//
//  Created by Stanislav Belsky on 5/31/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct LoadingData {
    var isAuthorized: Bool?
    var isPinSuccess: Bool?
    var isReachable: Bool?
    var defaultViewType: ViewTypes = .HomeViewType
    
    func detectStartView() -> AnyView{
        
        print("detectStartView", self)
        
        switch (isAuthorized, isPinSuccess, isReachable) {
        case (_, _, false):
            return AnyView(ErrorView())
        case (false, _, _):
            return AnyView(AuthView().environmentObject(AuthViewModel()))
        case (true, false, _):
            return AnyView(AuthView().environmentObject(AuthViewModel()))
        case (true, true, true):
            return AnyView(defaultViewType.getView())
        default:
            return AnyView(EmptyView())
        }
        
    }
    
}
