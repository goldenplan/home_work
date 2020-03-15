//
//  TitleView.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct TitleView: View{
    var title: String
    
     var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame( height: 44 )
            HStack{
                Spacer()
                Text(title)
                    .foregroundColor(Color.blue)
                    .padding(.leading, 20)
                    .font(Font.system(size: 20.0))
                Spacer()
            }
        }
    }
}
