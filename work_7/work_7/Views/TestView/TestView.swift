//
//  TestView.swift
//  work_7
//
//  Created by Stanislav Belsky on 5/23/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject private var navigationStack: NavigationStack
    
    @EnvironmentObject private var testViewModel: TestViewModel
    
    @State var sliderValue = 0.0
    var minimumValue = 0.0
    var maximumvalue = 100.0
    
    var body: some View {
        ZStack{
            VStack{
                NavigatioView(title: "TestView", action: {
                    self.navigationStack.pop()
                })
                Spacer()
            }
            
            VStack{
                
                HStack{
                    Text("Make array from words")
                    Spacer()
                    if testViewModel.creationAllWordsTime != nil{
                        Text("\(testViewModel.creationAllWordsTime!)")
                    }else{
                        Text("running")
                    }
                    
                }.padding()
                
                HStack{
                    Text("Tuples creation")
                    Spacer()
                    if testViewModel.creationTublesTime != nil{
                        Text("\(testViewModel.creationTublesTime!)")
                    }else{
                        Text("running")
                    }
                    
                }.padding()
                
                if testViewModel.sliderValue != 0{
                    Text("\(Int(testViewModel.sliderValue))")
                }else{
                    Text("no limit")
                }
                
                
                Slider(value: $testViewModel.sliderValue, in: testViewModel.minimumValue...testViewModel.maximumvalue)
                
                HStack{
                    Text("Searching time")
                    Spacer()
                    if testViewModel.searchingTime != nil{
                        Text("\(testViewModel.searchingTime!)")
                    }else{
                        Text("running")
                    }
                    
                }.padding()
                
                HStack{
                    Text("Find the number of")
                    Spacer()
                    if testViewModel.searchingTime != nil{
                        Text("\(testViewModel.findCount)")
                    }else{
                        Text("running")
                    }
                    
                }.padding()
                
                
                Button( action: testViewModel.runTest){
                    Text("Run test")
                        .padding(.leading, 20)
                }
                .foregroundColor(Color.blue)
                
            }.padding()
            
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}


