//
//  MenuView.swift
//  iOS
//
//  Created by Stanislav Belsky on 6/7/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject private var menuViewModel: MenuViewModel
    
    var body: some View {
        NavigationView{
            ZStack{
                
                NavigationLink(destination: EmptyView(), tag: 0, selection: self.$menuViewModel.selectedView) {
                EmptyView()}.opacity(0)
                
                VStack(spacing: 50){
                    
//                    .environmentObject(GameViewModel())
                    NavigationLink(destination: GameView().modifier(ViewModels()), tag: 1, selection: self.$menuViewModel.selectedView) {
                        ExtraText(title: "Play")
                    }.buttonStyle(PlainButtonStyle())
                    
                    
                    //.environmentObject(LeaderboardViewModel())
                    NavigationLink(destination: LeaderboardView().modifier(ViewModels()), tag: 2, selection: self.$menuViewModel.selectedView) {
                        ExtraText(title: "Leaderboard")
                    }.buttonStyle(PlainButtonStyle())
                    
                    //.environmentObject(SettingsViewModel())
                    NavigationLink(destination: SettingsView().modifier(ViewModels()), tag: 3, selection: self.$menuViewModel.selectedView) {
                        ExtraText(title: "Settings")
                    }.buttonStyle(PlainButtonStyle())
                    
                }
            }
            .frame(width: menuViewModel.isHidden ? 0 : kViewWidth, height: kViewHeight, alignment: .center)
            
        }
        
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}


struct ViewModels: ViewModifier {
    static var game = GameViewModel()
    static var settings = SettingsViewModel()
    static var menu = MenuViewModel()
    func body(content: Content) -> some View {
        content
            // services
            .environmentObject(Self.menu)
            .environmentObject(Self.game)
            .environmentObject(Self.settings)
    }
}
