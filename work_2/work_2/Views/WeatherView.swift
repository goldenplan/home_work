//
//  NextView.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct WeatherView: View {
    
    @EnvironmentObject var navigation: NavigationStack
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        VStack{
            BackView( title: "Weather",  action:{
                self.navigation.back()
            }, homeAction: {
               self.navigation.home()
            })
            VStack{
                Spacer()
                Text(weatherViewModel.cityName)
                    .font(Font.system(size: 30.0))
                    .fontWeight(.bold)
                Text(weatherViewModel.weather)
                    .font(Font.system(size: 25.0))
                    .fontWeight(.light)
                Spacer()
                Button(action: {
                    self.navigation.push(NavigationItem(view: AnyView(FirstBlankView())))
                }) {
                    Text("Open FirstBlankView")
                }
                Spacer()
            }
        }
    }
}


struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}



