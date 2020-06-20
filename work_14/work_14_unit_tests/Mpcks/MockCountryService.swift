//
//  MockCountryService.swift
//  work_14
//
//  Created by Stanislav Belsky on 6/20/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine

final class MockCountryService: CountryService {
    
    var coutryDataArray: [CountryData]?
    var langDataArray: [LangData]?
    var apiError: ApiError?
    
    override func getLanguages() -> Future<[LangData], ApiError>{
        return Future<[LangData], ApiError>{ [unowned self] promise in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if self.langDataArray != nil{
                    promise(.success(self.langDataArray!))
                }else if self.apiError != nil{
                    promise(.failure(self.apiError!))
                }
            }
            
        }
    }
    
    
    override func getCities(lang: String, page: Int) -> Future<[CountryData], ApiError>{
        return Future<[CountryData], ApiError>{ [unowned self] promise in
            print(">>>getCities", lang, page)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if self.langDataArray != nil{
                    promise(.success(self.coutryDataArray!))
                }else if self.apiError != nil{
                    promise(.failure(self.apiError!))
                }
            }
            
        }
    }
    
}
