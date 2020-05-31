//
//  AuthView.swift
//  work_11
//
//  Created by Stanislav Belsky on 5/31/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Enter authorization")
            Button(action: {
                print("Correct auth")
                self.authViewModel.success()
            }) {
                Text("Correct")
            }
            Button(action: {
                print("Incorrect auth")
                self.authViewModel.fail()
            }) {
                Text("Incorrect")
            }
        }
        
    }

}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
