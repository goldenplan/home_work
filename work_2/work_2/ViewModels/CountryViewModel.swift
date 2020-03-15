//
//  CountryViewModel.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class CountryViewModel: ObservableObject{
    
    var countryService = CountryService.shared
    
    @Published var languages: [LangData] = []
    
    @Published var currentLangIndex: Int = 0
    
    @Published var currentPage: Int = 0
    
    @Published var countries: [CountryData] = []
    
    @ObservedObject var isLoading = ObservableBox<Bool>(false)
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        
        $currentLangIndex.dropFirst().sink { (value) in
            self.clearData()
        }
        .store(in: &cancellableSet)
        
        $currentPage.dropFirst().sink { (value) in
            self.updateCities(lang: self.languages[self.currentLangIndex].code, page: value)
        }
        .store(in: &cancellableSet)
        
         countryService.getLanguages()
        .replaceError(with: [])
        .eraseToAnyPublisher()
        .sink(receiveCompletion: { (complition) in
                if case let .failure(error) = complition{
                    print("Error:", error)
                }
            }) { (data) in
                print("Languages: ", data)
                self.languages.append(contentsOf: data)
                if data.count > 0{
                    self.currentLangIndex = 0
                }
            }
        .store(in: &cancellableSet)
        
    }
    
    func increasePage(){
        currentPage += 1
    }
    
    func clearData(){
        countries = []
        currentPage = 0
    }
    
    func updateCities(lang: String, page: Int){
        
        isLoading.value = true
        
        countryService.getCities(lang: lang, page: page)
        .replaceError(with: [])
        .eraseToAnyPublisher()
        .sink(receiveCompletion: { (complition) in
            
                self.isLoading.value = false
            
                if case let .failure(error) = complition{
                    print("Error:", error)
                }
            
            }) { (data) in
                print("Countries: ", data)
                
                self.isLoading.value = false
                
                self.countries.append(contentsOf: data)
            }
        .store(in: &cancellableSet)
        
    }
    
    deinit {
        for cancell in cancellableSet{
            cancell.cancel()
        }
    }
}
