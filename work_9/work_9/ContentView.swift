//
//  ContentView.swift
//  work_9
//
//  Created by Stanislav Belsky on 5/12/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let digitsArray = ["0","1","2","4","10","12", "22"]
    
    let transModel = TransModel.instance
    
    var body: some View {
        ForEach(digitsArray, id: \.self) {
            Text("\(self.transModel.pineapplesCountUniversal(count: Int($0)!))")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
