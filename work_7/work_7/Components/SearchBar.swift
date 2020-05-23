//
//  SearchBar.swift
//  work_7
//
//  Created by Stanislav Belsky on 5/23/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    
    @EnvironmentObject private var navigationStack: NavigationStack
    
    @Binding var searchText: String
    @Binding var showCancelButton: Bool
    
    var body: some View{
        HStack {
            Button( action: {
                self.navigationStack.pop()
            }){
                Image(uiImage: UIImage(systemName:  "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large))! )
                .padding(.leading, 20)
            }
            .foregroundColor(Color.blue)
            HStack {
                
                
                
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

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}
