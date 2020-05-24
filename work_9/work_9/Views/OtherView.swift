//
//  ContentView.swift
//  work_9
//
//  Created by Stanislav Belsky on 5/12/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import SwiftUI

struct OtherView: View {
    
    @EnvironmentObject private var navigationStack: NavigationStack
    
    let digitsArray = ["0","1","2","4","10","12", "22"]
    
    let transModel = TransModel.instance
    
    var body: some View {
        ZStack{
            
            VStack{
                NavigatioView(title: "OtherView", action: {
                    self.navigationStack.pop()
                })
                Spacer()
            }
            
            VStack{
                ForEach(digitsArray, id: \.self) {
                    Text("\(self.transModel.pineapplesCountUniversal(count: Int($0)!))")
                        .padding()
                }
            }
            
        }
        
    }
}

struct OtherView_Previews: PreviewProvider {
    static var previews: some View {
        OtherView()
    }
}
