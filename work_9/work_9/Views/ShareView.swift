//
//  ShareView.swift
//  work_9
//
//  Created by Stanislav Belsky on 5/24/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct ShareView: View {
    
    @EnvironmentObject private var navigationStack: NavigationStack
    
    @EnvironmentObject private var shareViewModel: ShareViewModel
    
    var body: some View {
        ZStack{
            
            VStack{
                NavigatioView(title: "ShareView", action: {
                    self.navigationStack.pop()
                })
                Spacer()
            }
            
            VStack{
                
                VStack{
                    
                    Picker("Locales", selection: $shareViewModel.currentLocaleIndex) {
                        ForEach(0 ..< shareViewModel.localeList.count) { index in
                            Text("\(self.shareViewModel.localeList[index].name)").tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    HStack{
                        if !shareViewModel.fraseForTranslate.isEmpty{
                            VStack{
                                Text("Текст для перевода:")
                                Text(" \(shareViewModel.fraseForTranslate)")
                            }
                        }else{
                            Text("Текст для перевода отсутствует")
                        }
                    }.padding()

                    HStack{
                        if !shareViewModel.translatedFrase.isEmpty{
                            VStack{
                                Text("Перевод на \(shareViewModel.localeList[shareViewModel.currentLocaleIndex].name):")
                                Text("\(shareViewModel.translatedFrase)")
                            }
                        }
                    }.padding()
                }.padding(EdgeInsets(top: 60, leading: 0, bottom: 0, trailing: 0))
                
                Spacer()
            }
            
        }
        
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
    }
}
