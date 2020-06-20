//
//  CountryApi.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine

class CountryService: CountryServiceProtocol {
    
    static let shared = CountryService()
    
    private let urlSession = URLSession.shared
    private var subscriptions = Set<AnyCancellable>()
    
    private var jsonDecoder: JSONDecoder{
        let jsonDecoder = JSONDecoder()
//        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return jsonDecoder
    }
    
    func getLanguages() -> Future<[LangData], ApiError>{
        return Future<[LangData], ApiError>{  [unowned self]  promise in
            do{
                
                let request = try CountryRoute.getLang.asURLRequest()
                
                self.urlSession.dataTaskPublisher(for: request)
                    .tryMap { (data, response) -> Data in
                        
                        guard let httpResponse = response as? HTTPURLResponse,
                            200...299 ~= httpResponse.statusCode else{
                                throw ApiError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
                        }
                        
                        return data
                }
                .decode(type: LangModel.self, decoder: self.jsonDecoder)
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
                    
                    }) { promise(.success($0.data)) }
                .store(in: &self.subscriptions)
                
            }catch{
                promise(.failure(.urlError(URLError(URLError.unsupportedURL))))
            }
        }
    }
    
    func getCities(lang: String, page: Int) -> Future<[CountryData], ApiError>{
        return Future<[CountryData], ApiError>{  [unowned self]  promise in
            do{
                
                let request = try CountryRoute.getCities(lang: lang, page: page).asURLRequest()
                
                self.urlSession.dataTaskPublisher(for: request)
                    .tryMap { (data, response) -> Data in
                        
                        guard let httpResponse = response as? HTTPURLResponse,
                            200...299 ~= httpResponse.statusCode else{
                                throw ApiError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
                        }
                        
                        return data
                }
                .decode(type: CountryModel.self, decoder: self.jsonDecoder)
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
                    
                    }) { promise(.success($0.data)) }
                .store(in: &self.subscriptions)
                
            }catch{
                promise(.failure(.urlError(URLError(URLError.unsupportedURL))))
            }
        }
    }
    
}

enum CountryEndPoint: String, CaseIterable {
    case getLanguages = "locale/languages"
    case getCities = "geo/cities"
}
