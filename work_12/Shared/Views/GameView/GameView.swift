//
//  GameView.swift
//  MacOS
//
//  Created by Stanislav Belsky on 6/7/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct GameView: View {
    
    @EnvironmentObject private var menuViewModel: MenuViewModel
    
    @EnvironmentObject private var gameViewModel: GameViewModel
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text("Call for death;))")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("До конца игры: \(gameViewModel.remainingTime.stringFromTimeInterval())")
                .font(.title)
                .foregroundColor(.gray)
            
            if gameViewModel.remainingTime == 0{
                Text("Конец игры")
                .frame(maxWidth: .infinity)
                .font(.title).padding()
                .background(Color.red)
                .layoutPriority(2)
                .foregroundColor(.white)
            }else{
                Button(action: {
                    self.gameViewModel.increase()
                }) {
                    ExtraText(title: "\(self.gameViewModel.count)")
                    
                }
                .buttonStyle(PlainButtonStyle())
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
            }
            
            
            
            
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
            self.gameViewModel.startGame()
            self.menuViewModel.isHidden = true
        }.onDisappear{
            self.gameViewModel.stopGame()
            self.menuViewModel.isHidden = false
        }.frame(maxWidth: .infinity)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
