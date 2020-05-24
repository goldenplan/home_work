//
//  RootView.swift
//  work_9
//
//  Created by Stanislav Belsky on 5/24/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct RootView: View {
    
    @EnvironmentObject private var translateViewModel: ShareViewModel
    
    var body: some View {

        NavigationStackView(transitionType:.default) {
            HomeView()
        }
        
    }
    
}


struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
