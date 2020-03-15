//
//  NavigationHost.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct NavigationHost: View{
    
    @EnvironmentObject var navigation: NavigationStack
    
    var body: some View {
        self.navigation.currentView.view
    }
}
