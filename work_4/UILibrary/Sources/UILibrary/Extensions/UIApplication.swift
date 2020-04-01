//
//  File.swift
//  
//
//  Created by Stanislav Belsky on 01.04.2020.
//

import Foundation
import UIKit

extension UIApplication {
    public func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}
