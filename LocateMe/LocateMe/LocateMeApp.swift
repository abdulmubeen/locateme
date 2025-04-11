//
//  LocateMeApp.swift
//  LocateMe
//
//  Created by Abdul Mubeen Mohammed on 2025-04-11.
//

import SwiftUI

@main
struct LocateMeApp: App {
        let persistenceController = PersistenceController.shared
        
        var body: some Scene {
            WindowGroup {
                TabView {
                    SearchView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    
                    FavoritesView()
                        .tabItem {
                            Image(systemName: "star.fill")
                            Text("Favorites")
                        }
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .accentColor(.blue)
            }
        }
}
