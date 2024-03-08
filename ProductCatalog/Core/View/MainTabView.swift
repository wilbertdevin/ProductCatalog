//
//  MainTabView.swift
//  ProductCatalog
//
//  Created by Wilbert Devin Wijaya on 07/03/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ProductView()
                .tabItem {
                    Image(systemName: "list.bullet.clipboard")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            
            FavoriteProductView()
                .tabItem {
                    Image(systemName: "heart")
                }
        }
        .accentColor(.black)
    }
}

#Preview {
    MainTabView()
}
