//
//  WeatherViewModel.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class WeatherViewModel: ObservableObject{
    
    var weatherService = WeatherService.shared
    
    @Published var country: String!
    @Published var cityName: String!
    @Published var weather: String = "--ºC"
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(countryData: CountryData) {
        
        cityName = countryData.city
        country = countryData.country
        
        weatherService.getWeather(longitude: countryData.longitude, latitude: countryData.latitude)
        .eraseToAnyPublisher()
        .sink(receiveCompletion: { (complition) in
                if case let .failure(error) = complition{
                    print("Error:", error)
                }
            }) { (data) in
                print("Weather: ", data)
                self.weather = "\(data.main.temp)ºC"
            }
        .store(in: &cancellableSet)
        
    }

    deinit {
        for cancell in cancellableSet{
            cancell.cancel()
        }
    }
}
