//
//  TabBarModel.swift
//  work_1
//
//  Created by Stanislav Belsky on 28.02.2020.
//  Copyright © 2020 Stanislav Blesky. All rights reserved.
//

import Foundation

class TabViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var selectedFruit: Int? = nil
}
