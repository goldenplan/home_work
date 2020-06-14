//
//  LeaderboardView.swift
//  MacOS
//
//  Created by Stanislav Belsky on 6/7/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct LeaderboardView: View {
    
    @EnvironmentObject private var menuViewModel: MenuViewModel
    
    @State var list: [[String: Int]] = [[:]]
    
    var body: some View {
        
        VStack{
            Text("Лучшие результаты")
                .font(.largeTitle)
            
            Spacer()
            
            VStack{
                List {
                    ForEach((list), id: \.self) { item in
                        HStack{
                            Spacer()
                            Text("За \(item.keys.first!) секунд ..... \(item.values.first!) кликов").font(.subheadline)
                            Spacer()
                        }
                    }
                }
            }.frame(height: CGFloat(150))
            
            Spacer()
            
            #if os(OSX)
                Button(action: {
                    self.menuViewModel.selectedView = 0
                }) {
                    ExtraText(title: "Back")

                }
                .buttonStyle(PlainButtonStyle())
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
            #endif
            
        }.onAppear{
            self.menuViewModel.isHidden = true
            
            let bestResult: [String: Int] = Util.load(key: kResultKey)
            self.list = bestResult.map { (key, value) -> [String: Int] in
                [key: value]
            }.sorted { $0.keys.first! < $1.keys.first! }
            
        }.onDisappear{
            self.menuViewModel.isHidden = false
        }.frame(maxWidth: .infinity)
        
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
