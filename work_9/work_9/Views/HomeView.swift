//
//  HomeView.swift
//  work_9
//
//  Created by Stanislav Belsky on 5/24/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var navigationStack: NavigationStack
    
    var body: some View {
        
        VStack{
                     
            Button(action: {
                let url = URL(string: "https://file.ilook.su/public/test.html")!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }) {
                Text("Open test site")
            }.padding()
            
            Button(action: {
                self.navigationStack.push(ShareView().environmentObject(ShareViewModel()), withId: String(describing: ShareView.self))
            }) {
                Text("ShareView")
            }.padding()
            
            Button(action: {
                self.navigationStack.push(OtherView(), withId: String(describing: OtherView.self))
            }) {
                Text("OtherView")
            }.padding()
            
            
        }.onAppear(){
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
                let fraseFromUrl = sceneDelegate.fraseFromUrl
            else {
              return
            }
            
            sceneDelegate.fraseFromUrl = nil
            self.navigationStack.push(ShareView().environmentObject(ShareViewModel(fraseForTranslate: fraseFromUrl)))
        }
        
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
