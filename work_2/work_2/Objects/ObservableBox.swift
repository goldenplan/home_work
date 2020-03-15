//
//  ObservableBox.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

class ObservableBox<Value>: ObservableObject {
  @Published var value: Value

  init(_ value: Value) {
    self.value = value
  }
}
