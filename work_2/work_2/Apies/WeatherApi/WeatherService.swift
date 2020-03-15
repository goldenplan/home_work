//
//  WeatherApi.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine

class WeatherService {
    
    static let shared = WeatherService()
    
    private let urlSession = URLSession.shared
    private var subscriptions = Set<AnyCancellable>()
    
    private var jsonDecoder: JSONDecoder{
            let jsonDecoder = JSONDecoder()
//        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return jsonDecoder
        }
    
    func getWeather(longitude: Double, latitude: Double) -> Future<WeatherModel, ApiError>{
           return Future<WeatherModel, ApiError>{  [unowned self]  promise in
               do{
                   
                let request = try WeatherRoute.getWeather(longitude: longitude, latitude: latitude).asURLRequest()
                   
                   self.urlSession.dataTaskPublisher(for: request)
                       .tryMap { (data, response) -> Data in
                        
                           guard let httpResponse = response as? HTTPURLResponse,
                               200...299 ~= httpResponse.statusCode else{
                                   throw ApiError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
                           }
                           
                           return data
                   }
                   .decode(type: WeatherModel.self, decoder: self.jsonDecoder)
                   .receive(on: RunLoop.main)
                   .sink(receiveCompletion: { (complition) in
                       
                           if case let .failure(error) = complition{
                               switch error {
                               case let urlError as URLError:
                                   promise(.failure(.urlError(urlError)))
                               case let decodingError as DecodingError:
                                   promise(.failure(.decodingError(decodingError)))
                               case let apiError as ApiError:
                                   promise(.failure(apiError))
                               default:
                                   promise(.failure(.genericError))
                               }
                           }
                       
                       }) { promise(.success($0)) }
                   .store(in: &self.subscriptions)
                   
               }catch{
                   promise(.failure(.urlError(URLError(URLError.unsupportedURL))))
               }
           }
       }
    
}
