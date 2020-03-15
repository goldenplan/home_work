//
//  NavigationStack.swift
//  work_2
//
//  Created by Stanislav Belsky on 14.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

final class NavigationStack: ObservableObject  {
    
    @Published var viewStack: [NavigationItem] = []
    @Published var currentView: NavigationItem
    
    init(_ currentView: NavigationItem ){
        self.currentView = currentView
    }
    
    func back(){
        
        if viewStack.count == 0{
            return
        }
        
        let last = viewStack.count - 1
        currentView = viewStack[last]
        viewStack.remove(at: last)
    
    }
    
    func push(_ view:NavigationItem){
    
        viewStack.append(currentView)
        currentView = view
    }
    
    func home(){
        while viewStack.count > 0 {
            back()
        }
    }
    
    func forceHome(){
        
        currentView = NavigationItem( view: AnyView(HomeView().environmentObject(CountryViewModel())))
         viewStack.removeLast()
    }
}
