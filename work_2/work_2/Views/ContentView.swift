//
//  ContentView.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationHost()
            .environmentObject(
                NavigationStack( NavigationItem( view: AnyView(HomeView().environmentObject(CountryViewModel())))))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
