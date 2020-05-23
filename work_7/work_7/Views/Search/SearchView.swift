//
//  SearchView.swift
//  work_7
//
//  Created by Stanislav Belsky on 5/23/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var searchModel: SearchViewModel
    
    @EnvironmentObject private var navigationStack: NavigationStack
    
    var body: some View {
        ZStack{
            VStack{
                NavigatioView(title: "SearchView", action: {
                    self.navigationStack.pop()
                })
                Spacer()
            }
            NavigationView {
                Group {
                    VStack {
                        SearchBar(searchText: $searchModel.searchTerm,
                                  showCancelButton: $searchModel.showCancelButton)
                        List(searchModel.movies, id: \.self) { game in
                            Text(game)
                        }
                    }
                }
                .navigationBarTitle(Text("Movies"))
            }
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


