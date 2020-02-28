//
//  FruitDetailView.swift
//  work_1
//
//  Created by Stanislav Belsky on 28.02.2020.
//  Copyright © 2020 Stanislav Blesky. All rights reserved.
//

import SwiftUI

struct FruitDetailView: View {
    
    var selectedFruit: String
    
    var body: some View {
        Text(selectedFruit)
    }
}

struct FruitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FruitDetailView(selectedFruit: "Apple")
    }
}
