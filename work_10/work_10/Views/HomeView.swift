//
//  HomeView.swift
//  work_10
//
//  Created by Stanislav Belsky on 5/25/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var navigationStack: NavigationStack
    
    var body: some View {
        
        VStack{
            Button(action: {
                self.navigationStack.push(TestView().environmentObject(TestViewModel()), withId: String(describing: TestView.self))
            }) {
                Text("TestView")
            }.padding()
            
//            Button(action: {
//                self.navigationStack.push(SearchView().environmentObject(SearchViewModel()))
//            }) {
//                Text("SearchView")
//            }.padding()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

