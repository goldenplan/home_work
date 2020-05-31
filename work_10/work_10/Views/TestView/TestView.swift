//
//  TestView.swift
//  work_10
//
//  Created by Stanislav Belsky on 5/25/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject private var navigationStack: NavigationStack
    
    @EnvironmentObject private var testViewModel: TestViewModel
    
    @State var showsAlert = false
    
    var body: some View {
        ZStack{
            VStack{
                NavigatioView(title: "TestView", action: {
                    self.navigationStack.pop()
                },homeAction: {
                    print("hi")
                    self.showsAlert.toggle()
                })
                Spacer()
            }
            
            VStack{
                
                List(testViewModel.taskList, id: \.id) { task in
                  VStack {
                    HStack{
                        Text("Task:")
                        Spacer()
                        Text(task.type)
                    }
                    HStack{
                        Text("id:")
                        Spacer()
                        Text(task.name)
                    }
                    HStack{
                        Text("start:")
                        Spacer()
                        Text("\(Util.dateToString(date: task.startDate))")
                    }
                    HStack{
                        Text("progress:")
                        Spacer()
                        Text("\(Int(task.progress * 100))%")
                    }
                    HStack{
                        Text("status:")
                        Spacer()
                        if task.remaningTime == 0{
                            Text("Выполняется")
                        }else{
                            Text("Выполннено за \(task.remaningTime)")
                        }
                    }
                    
                  }
                }
                
            }.padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
            
        }.actionSheet(isPresented: $showsAlert) {
            ActionSheet(
                title: Text("Добавление задачи"),
                message: Text("Выберите тип задачи"),
                buttons: [
                    .default(Text("Add FirstTask 10s."),action: {
                        self.testViewModel.runFirstTask()
                    }),
                    .default(Text("Add SecondTask 20s."),action: {
                        self.testViewModel.runSecondTask()
                    }),
                    .cancel()])
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}



