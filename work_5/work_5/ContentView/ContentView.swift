//
//  ContentView.swift
//  work_4
//
//  Created by Stanislav Belsky on 31.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import SwiftUI
import UILibrary

struct ContentView: View {
    
    @EnvironmentObject var viewModel: MovieViewModel
    
    var body: some View {
        NavigationView {
            Group {
                VStack {
                    SearchBar(searchText: $viewModel.searchTerm,
                        showCancelButton: $viewModel.showCancelButton)
                    List(viewModel.movies, id: \.title) { game in
                        Text(verbatim: game.title)
                    }
                }
            }
            .onAppear(){
                if let state = StateService.loadState(){
                    self.viewModel.searchTerm = state.lastSearch
                }
            }
            .navigationBarTitle(Text("Movies"))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.colorScheme, .light)
            
            ContentView()
                .environment(\.colorScheme, .dark)
        }
    }
}

//struct ResignKeyboardOnDragGesture: ViewModifier {
//    var gesture = DragGesture().onChanged{_ in
//        UIApplication.shared.endEditing(true)
//    }
//    func body(content: Content) -> some View {
//        content.gesture(gesture)
//    }
//}



