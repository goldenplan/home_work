//
//  SecondContainerView.swift
//  work_1
//
//  Created by snake on 28.02.2020.
//  Copyright © 2020 Stanislav Blesky. All rights reserved.
//

import SwiftUI

struct SecondContainerView: View {
    
    @Binding var selected: Int?
    
    @EnvironmentObject var viewModel: FruitsViewModel
    
    var body: some View {
        NavigationView{
            List{
                ForEach(Range(0...viewModel.list.count-1)){ iteration in
                    
                    NavigationLink(destination: FruitDetailView(selectedFruit: self.viewModel.list[iteration]), tag: iteration, selection: self.$selected) {
                        Text("\(self.viewModel.list[iteration])")
                    }
                    
                }
            }
        }
    }
}

struct SecondContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SecondContainerView(selected: .constant(2)).environmentObject(FruitsViewModel())
    }
}
