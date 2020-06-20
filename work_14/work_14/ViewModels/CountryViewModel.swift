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
    
    var countryService: CountryServiceProtocol
    
    @Published var languages: [LangData] = []
    
    @Published var currentLangIndex: Int = 0
    
    @Published var currentPage: Int = 0
    
    @Published var countries: [CountryData] = []
    
    @ObservedObject var isLoading = ObservableBox<Bool>(false)
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(countryService: CountryServiceProtocol) {
        
        self.countryService = countryService
        
        $currentLangIndex.dropFirst().sink { (value) in
            self.currentPage = 0
        }
        .store(in: &cancellableSet)

        $currentPage.dropFirst().sink { (value) in
            self.updateCities(index: self.currentLangIndex, page: value)
        }
        .store(in: &cancellableSet)
        
        updateLanguages()
    }
    
    func updateLanguages(){
        
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
    
    func updateCities(index: Int, page: Int){
        
        guard languages.count > 0 else { return }
        
        isLoading.value = true
        
        countryService.getCities(lang: languages[currentLangIndex].code, page: page)
        .replaceError(with: [])
        .eraseToAnyPublisher()
        .sink(receiveCompletion: { (complition) in
            
                self.isLoading.value = false
            
                if case let .failure(error) = complition{
                    print("Error:", error)
                }
            
            }) { (data) in
                print("Countries for \(self.languages[self.currentLangIndex]) \(page): ", data.count, data.first?.country ?? "nil")
                
                self.isLoading.value = false
                
                if page == 0{
                    self.countries = data
                }else{
                    self.countries.append(contentsOf: data)
                }
                
            }
        .store(in: &cancellableSet)
        
    }
    
    deinit {
        for cancell in cancellableSet{
            cancell.cancel()
        }
    }
}
