//
//  ApiService.swift
//  work_3
//
//  Created by Stanislav Belsky on 26.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine

class ApiService {
    
    private let urlSession = URLSession.shared
    private var subscriptions = Set<AnyCancellable>()
    
    func fetch<T: Decodable>(_ route: URLRequestConvertible, type: T.Type) -> Future<T, AppError> {
        
        return Future<T, AppError>{  [unowned self]  promise in
            do{
                
                let request = try route.asURLRequest()
                print("Запрос пошел", request.urlRequest ?? "nil")
                
                self.urlSession.dataTaskPublisher(for: request)
                    .tryMap { (data, response) -> Data in
                        
                        if let apiErrors = try? APIHelpers.jsonDecoder.decode(ErrorsData.self, from: data){
                            throw AppError.apiErrors(apiErrors.errors)
                        }
                        
                        if let apiError = try? APIHelpers.jsonDecoder.decode(ErrorData.self, from: data){
                            throw AppError.apiError(apiError)
                        }
                     
                        guard let httpResponse = response as? HTTPURLResponse,
                            200...299 ~= httpResponse.statusCode else{
                                throw AppError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
                        }
                        
                        return data
                }
                .decode(type: T.self, decoder: APIHelpers.jsonDecoder)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (complition) in
                    
                        if case let .failure(error) = complition{
                            switch error {
                            case let urlError as URLError:
                                promise(.failure(.urlError(urlError)))
                            case let decodingError as DecodingError:
                                promise(.failure(.decodingError(decodingError)))
                            case let apiError as AppError:
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
        
//        URLSession.shared.dataTaskPublisher(for: request)
//            .map { $0.data }
//            .decode(type: T.self, decoder: APIHelpers.jsonDecoder)
//            .receive(on: RunLoop.main)
//            .eraseToAnyPublisher()
    }
    
}
