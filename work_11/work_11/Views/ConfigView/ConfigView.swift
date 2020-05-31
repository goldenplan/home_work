//
//  ConfigView.swift
//  work_11
//
//  Created by Stanislav Belsky on 5/30/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import SwiftUI

struct ConfigView: View {
    
    @EnvironmentObject private var configViewModel: ConfigViewModel

    var body: some View {

            Form {
                Section(header: Text("Loading config")) {
                    Picker(selection: $configViewModel.configData.startViewType,
                           label: Text("Select start view")) {
                            ForEach(ViewTypes.startable, id: \.self) { view in
                                Text("\(view.rawValue)").tag(view)
                            }
                    }
                    Toggle(isOn: $configViewModel.configData.isAuthorized,
                           label: {
                            Text("User authorized")
                    })
                    Toggle(isOn: $configViewModel.configData.isNeedPinEnter,
                           label: {
                            Text("User must enter pincode")
                    })
                    Button(action: {
                        print("Restart app")
                        self.configViewModel.restart()
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Restart app")
                            Spacer()
                        }
                        
                    })
                    Button(action: {
                        print("Reset")
                        self.configViewModel.reset() 
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Reset")
                            Spacer()
                        }
                        
                    })
                }
            }
            .navigationBarTitle(Text("Settings"))
            .onDisappear {
                self.configViewModel.save()
        }

        
    }

}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView().environmentObject(ConfigViewModel())
    }
}




