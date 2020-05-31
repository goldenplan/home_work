//
//  PinEnterView.swift
//  work_11
//
//  Created by Stanislav Belsky on 5/31/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct PinEnterView: View {

    @EnvironmentObject private var pinEnterViewModel: PinEnterViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Enter pincode")
            Button(action: {
                self.pinEnterViewModel.success()
            }) {
                Text("Correct")
            }
            Button(action: {
                
                self.pinEnterViewModel.fail()
            }) {
                Text("Incorrect")
            }
        }
        
    }

}

struct PinEnterView_Previews: PreviewProvider {
    static var previews: some View {
        PinEnterView()
    }
}
