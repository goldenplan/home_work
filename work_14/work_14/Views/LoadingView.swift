//
//  LoadingView.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct LoadingView: View{
    
    @Binding var isLoading: ObservableBox<Bool>
    
    var openHeight  : CGFloat = 44
    var closeHeight : CGFloat = 0
    
     var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame( height: isLoading.value ? openHeight : closeHeight)
            if isLoading.value{
                HStack{
                    Spacer()
                    Text("loading...")
                        .foregroundColor(Color.black)
                        .padding(.leading, 20)
                        .font(Font.system(size: 20.0))
                    Spacer()
                }
            }
        }
    }
}
