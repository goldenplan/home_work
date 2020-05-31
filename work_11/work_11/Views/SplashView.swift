//
//  SplashView.swift
//  work_11
//
//  Created by Stanislav Belsky on 5/30/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct SplashView: View {

    var body: some View {
        LoadingView(isShowing: .constant(true)) {
            EmptyView()
        }
    }

}
