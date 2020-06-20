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
    
    var weatherService: WeatherServiceProtocol!
    
    @Published var countryData: CountryData!
    @Published var weather: String = "--ºC"
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(countryData: CountryData, weatherService: WeatherServiceProtocol) {
        
        self.countryData = countryData
        
        self.weatherService = weatherService
        
        subscribeOnService()
    }
    
    func subscribeOnService(){
        
        weatherService.getWeather(longitude: countryData.longitude, latitude: countryData.latitude)
        .eraseToAnyPublisher()
        .sink(receiveCompletion: { (complition) in
                if case let .failure(error) = complition{
                    print("Error:", error)
                    self.weather = "--ºC"
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
