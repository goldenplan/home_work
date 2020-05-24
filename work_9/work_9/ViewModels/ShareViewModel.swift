//
//  RootViewModel.swift
//  work_9
//
//  Created by Stanislav Belsky on 5/24/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class ShareViewModel: ObservableObject {
    
    var fraseForTranslate: String = ""
    
    @Published var translatedFrase: String = ""
    
    var localeList: [(locale: Locale, name: String)] = [
        (locale: Locale(identifier: "ru"), name: "Русский"),
        (locale: Locale(identifier: "es"), name: "Испанский"),
        (locale: Locale(identifier: "en"), name: "Английский")
    ]
    
    @Published var currentLocaleIndex: Int = 0
    
    private var disposeBag = Set<AnyCancellable>()
    
    init(fraseForTranslate: String = "") {
        
        self.fraseForTranslate = fraseForTranslate
        
        $currentLocaleIndex.sink { [weak self] (value) in
            
            guard let strongSelf = self else { return }
            
            strongSelf.translate(localeIndex: value)
            
        }.store(in: &disposeBag)
        
    }
    
    func translate(localeIndex: Int){
        
//        let textString = "14/12/2000 2016-04-14 12 15.07"
        
        guard !fraseForTranslate.isEmpty else {
            translatedFrase = ""
            return
        }
        
        let elements = fraseForTranslate.split(separator: " ").map({ TextElement(String($0)) })
        translatedFrase = elements.map({ (item) -> String in
            item.translate(with: localeList[localeIndex].locale)
        }).reduce("", { (res, item) -> String in
            return res + " " + item
        })
        
    }

    deinit {
        for cancell in disposeBag{
            cancell.cancel()
        }
    }
    
}



