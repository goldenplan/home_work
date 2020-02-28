//
//  ContentView.swift
//  work_1
//
//  Created by snake on 28.02.2020.
//  Copyright © 2020 Stanislav Blesky. All rights reserved.
//

import SwiftUI

struct FirstContainerView: View {
    
    @EnvironmentObject var tabViewModel: TabViewModel
    
    var body: some View {
        Button(action: {
            print("hi")
            self.tabViewModel.selectedTab = 1
            self.tabViewModel.selectedFruit = 1
        }) {
            Text("Click me!")
        }
    }
}

struct FirstContainerView_Previews: PreviewProvider {
    static var previews: some View {
        FirstContainerView().environmentObject(TabViewModel())
    }
}
