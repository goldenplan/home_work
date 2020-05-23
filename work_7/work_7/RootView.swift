//
//  ContentView.swift
//  work_7
//
//  Created by Stanislav Belsky on 5/23/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import SwiftUI

struct RootView: View {
    
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
