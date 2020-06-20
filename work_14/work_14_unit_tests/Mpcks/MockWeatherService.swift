//
//  MockWeatherService.swift
//  work_14
//
//  Created by Stanislav Belsky on 6/20/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine

final class MockWeatherService: WeatherService {
    
    var weatherModel: WeatherModel?
    var apiError: ApiError?

    override func getWeather(longitude: Double, latitude: Double) -> Future<WeatherModel, ApiError> {
        return Future<WeatherModel, ApiError>{ [unowned self] promise in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if self.weatherModel != nil{
                    promise(.success(self.weatherModel!))
                }else if self.apiError != nil{
                    promise(.failure(self.apiError!))
                }
            }
            
        }
    }
}
