//
//  File.swift
//  
//
//  Created by Stanislav Belsky on 01.04.2020.
//

import SwiftUI

public struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var showCancelButton: Bool
    
//    public init(){}
    
    public init(searchText: Binding<String>, showCancelButton: Binding<Bool>) {

        self._searchText = searchText
        self._showCancelButton = showCancelButton
    }
    

    
    public var body: some View{
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

