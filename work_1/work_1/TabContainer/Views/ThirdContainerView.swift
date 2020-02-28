//
//  ThirdContainerView.swift
//  work_1
//
//  Created by snake on 28.02.2020.
//  Copyright © 2020 Stanislav Blesky. All rights reserved.
//

import SwiftUI

struct ThirdContainerView: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        Button(action: { self.isPresented.toggle() }) {
            
            Text("Press me!")
            
        }.sheet(isPresented: $isPresented) {
            
            Button(action: {
                self.isPresented = false
            }) {
                Text("Close me!")
            }
        }
    }
}

struct ThirdContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdContainerView()
    }
}
