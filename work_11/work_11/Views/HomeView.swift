//
//  HomeView.swift
//  work_11
//
//  Created by Stanislav Belsky on 5/30/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        
        NavigationView {
            VStack{
                NavigationLink(destination: ConfigView().environmentObject(ConfigViewModel())) {
                    Text("ConfigView")
                }
                .padding()
                Button(action: {
                    print("restart app")
                    Coordinator.instance.restart()
                }) {
                    Text("Restart app")
                }
                .padding()
            }
        }
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


