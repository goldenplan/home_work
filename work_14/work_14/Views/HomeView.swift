//
//  HomeView.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var countryViewModel: CountryViewModel
    @EnvironmentObject var navigation: NavigationStack
    
    var body: some View {
        VStack{
          TitleView( title: "Home view")
            Picker("", selection: $countryViewModel.currentLangIndex){
                ForEach(countryViewModel.languages, id: \.id) { item in
                    Text("\(item.name)")
                        .tag(self.countryViewModel.languages.firstIndex(where: {$0.code == item.code})!)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            List(countryViewModel.countries, id: \.self) { item in
                VStack(alignment: .leading) {
                    Group {
                        HStack{
                            Spacer()
                            VStack{
                                Text("Country: \(item.country)")
                                Text("City: \(item.city)")
                                Text("Latitude: \(item.latitude)")
                                Text("Longitude: \(item.longitude)")
                            }
                            Spacer()
                        }
                        
                    }
                    .onAppear() {
                        if self.countryViewModel.countries.isLast(item) {
                            self.countryViewModel.increasePage()
                        }
                    }
                    .onTapGesture {
                        self.navigation.push(NavigationItem(view: AnyView(WeatherView().environmentObject(WeatherViewModel(countryData: item, weatherService: WeatherService.shared)))))
                    }
                }
            }
            LoadingView(isLoading: $countryViewModel.isLoading)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
