//
//  BackView.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct BackView: View{
    var title: String
    var action: ()->Void
    var homeAction: ()->Void
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white).frame( height: 44 )
            HStack{
                Button( action: action){
                    Image(uiImage: UIImage(systemName:  "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large))! )
                    .padding(.leading, 20)
                }
                .foregroundColor(Color.blue)
                
                Spacer()
                
                Text(title)
                    .padding(.leading, 20)
                    .font(Font.system(size: 20))
                    .padding(.trailing, 20)
                
                Spacer()
                
                Button(action: homeAction){
                    Image(
                        uiImage: UIImage(systemName:  "house", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15.0, weight: .light, scale: .large))! )
                    .padding(.trailing, 20)
                }
                .foregroundColor(Color.blue)
            }
        }
    }
}


struct BackView_Previews: PreviewProvider {
    static var previews: some View {
        BackView(title: "Test", action: {}, homeAction: {})
    }
}
