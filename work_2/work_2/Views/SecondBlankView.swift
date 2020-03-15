//
//  SecondBlankView.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct SecondBlankView: View {
    
    @EnvironmentObject var navigation: NavigationStack
    
    var body: some View {
        VStack{
            BackView( title: "SecondBlankView",  action:{
                self.navigation.back()
            }, homeAction: {
               self.navigation.home()
            })
            VStack{
                Spacer()
                Text("Finish")
                Spacer()
            }
        }
    }
}


struct SecondBlankView_Previews: PreviewProvider {
    static var previews: some View {
        SecondBlankView()
    }
}





