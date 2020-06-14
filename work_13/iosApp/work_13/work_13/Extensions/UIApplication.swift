//
//  UIApplication.swift
//  work_13
//
//  Created by Stanislav Belsky on 6/14/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

