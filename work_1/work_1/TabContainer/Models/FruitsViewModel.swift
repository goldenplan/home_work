//
//  FruitsViewModel.swift
//  work_1
//
//  Created by snake on 28.02.2020.
//  Copyright © 2020 Stanislav Blesky. All rights reserved.
//

import Foundation

class FruitsViewModel: ObservableObject{
    
    @Published var selectedFruit: Int? = nil
    @Published private(set) var list = [
        "Яблоко",
        "Апельсин",
        "Мандарин",
        "Банан"
    ]
    
    
    
}
