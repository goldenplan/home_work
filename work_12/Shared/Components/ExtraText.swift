//
//  ExtraButton.swift
//  iOS
//
//  Created by Stanislav Belsky on 6/7/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct ExtraText: View  {
    
    private let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
        .frame(width: 200)
        .padding(12)
        .foregroundColor(Color.white)
        .background(Color.purple)
        .cornerRadius(8)
        .shadow(color: Color.purple, radius: 20, y: 5)
    }
    
    
}
