//
//  NavigatioView.swift
//  work_7
//
//  Created by Stanislav Belsky on 5/23/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct NavigatioView: View{
    
    @EnvironmentObject private var navigationStack: NavigationStack
    
    var title: String
    var action: (()->Void)? = nil
    var homeAction: (()->Void)? = nil
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white).frame( height: 44 )
            HStack{
                
                Spacer()

                Text(title)
                    .padding(.leading, 20)
                    .font(Font.system(size: 20))
                    .padding(.trailing, 20)

                Spacer()

            }
            
            HStack{
                if action != nil{
                    Button( action: action!){
                        Image(uiImage: UIImage(systemName:  "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large))! )
                        .padding(.leading, 20)
                    }
                    .foregroundColor(Color.blue)
                }
                

                Spacer()

                if homeAction != nil{
                    Button(action: homeAction!){
                        Image(
                            uiImage: UIImage(systemName:  "house", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15.0, weight: .light, scale: .large))! )
                        .padding(.trailing, 20)
                    }
                    .foregroundColor(Color.blue)
                }
                
            }
        }
    }
}


struct NavigatioView_Previews: PreviewProvider {
    static var previews: some View {
        NavigatioView(title: "Test", action: {}, homeAction: {})
    }
}

