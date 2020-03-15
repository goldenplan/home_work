//
//  FirstBlankView.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct FirstBlankView: View {
    
    @EnvironmentObject var navigation: NavigationStack
    
    var body: some View {
        VStack{
            BackView( title: "FirstBlankView",  action:{
                self.navigation.back()
            }, homeAction: {
               self.navigation.home()
            })
            VStack{
                Spacer()
                Button(action: {
                    self.navigation.push(NavigationItem(view: AnyView(SecondBlankView())))
                }) { 
                    Text("Open SecondBlankView")
                }
                Spacer()
            }
        }
    }
}


struct FirstBlankView_Previews: PreviewProvider {
    static var previews: some View {
        FirstBlankView()
    }
}
