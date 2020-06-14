//
//  SettingView.swift
//  MacOS
//
//  Created by Stanislav Belsky on 6/7/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var menuViewModel: MenuViewModel
    
    @EnvironmentObject private var settingsViewModel: SettingsViewModel
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text("Настройки")
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
            
            Spacer()
            
            Text("Время игры: \(Int(settingsViewModel.seconds))")
            
            #if os(tvOS)
                SliderView(value: $settingsViewModel.seconds, didSelectValue: settingsViewModel.didSelectValue)
            #else
                Slider(value: $settingsViewModel.seconds, in: 0...Double(settingsViewModel.maxValue), step: 1)
                .padding(20)
            #endif
            
            
            
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
        }.onDisappear{
            self.menuViewModel.isHidden = false
            self.settingsViewModel.update()
        }.frame(maxWidth: .infinity)
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
