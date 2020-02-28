//
//  TabContainer.swift
//  work_1
//
//  Created by snake on 28.02.2020.
//  Copyright © 2020 Stanislav Blesky. All rights reserved.
//

import SwiftUI



struct TabContainerView: View {
    
    @EnvironmentObject var tabViewModel: TabViewModel
    
    var body: some View {
        TabView(selection: $tabViewModel.selectedTab) {
            FirstContainerView()
                .tabItem {
                    Image(systemName: "tray.and.arrow.up.fill")
                    Text("Up")
                }
            .tag(0)
            

            SecondContainerView(selected: $tabViewModel.selectedFruit)
                .tabItem {
                    Image(systemName: "tray.and.arrow.down.fill")
                    Text("Down")
                }
            .tag(1)
            .environmentObject(FruitsViewModel())
            
            
            ThirdContainerView()
            .tabItem {
                Image(systemName: "tray.2.fill")
                Text("List")
            }
            .tag(2)
        }
    }
}

struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
                TabContainerView()
                    .environmentObject(TabViewModel())
                   .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                   .previewDisplayName("iPhone SE")

                TabContainerView()
                    .environmentObject(TabViewModel())
                   .previewDevice(PreviewDevice(rawValue: "iPad Air 2"))
                   .previewDisplayName("iPad Air 2")
                
            
             }
          }
        
}
