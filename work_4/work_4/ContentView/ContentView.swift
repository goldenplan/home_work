//
//  ContentView.swift
//  work_4
//
//  Created by Stanislav Belsky on 31.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import SwiftUI

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
            .navigationBarTitle(Text("Movies"))
        }
    }
}


struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var showCancelButton: Bool
    
    var body: some View{
        HStack {
            HStack {
                
                //                Image(systemName: "magnifyingglass")
                
                TextField("search", text: $searchText, onEditingChanged: { isEditing in
                    self.showCancelButton = true
                }, onCommit: {
                    print("onCommit")
                }).foregroundColor(.primary)
                
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 16, leading: 6, bottom: 16, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
            
            if showCancelButton  {
                Button("Cancel") {
                    UIApplication.shared.endEditing(true)
                    self.searchText = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton)
        .animation(.linear)
        
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

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}
