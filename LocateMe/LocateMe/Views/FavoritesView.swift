//
//  FavoritesView.swift
//  LocateMe
//
//  Created by Abdul Mubeen Mohammed on 2025-04-11.
//

import SwiftUI
import MapKit

struct FavoritesView: View {
    // Fetch favorites sorted by timestamp (most recent first).
    @FetchRequest(entity: FavoritePlace.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \FavoritePlace.timestamp, ascending: false)])
    var favorites: FetchedResults<FavoritePlace>
    
    var body: some View {
        NavigationView {
            List(favorites, id: \.self) { favorite in
                NavigationLink(destination: MapViewFromFavorite(favorite: favorite)) {
                    Text(favorite.name ?? "Unknown Place")
                        .font(.system(size: 16, weight: .medium))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.95, green: 0.98, blue: 0.95))
                                .shadow(color: Color.green.opacity(0.2), radius: 2, x: 0, y: 1)
                        )
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Favorites")
            .padding(.top)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.97, green: 0.97, blue: 1.0)]),
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
            )
        }
    }
}

struct MapViewFromFavorite: View {
    var favorite: FavoritePlace
    @State private var region: MKCoordinateRegion
    
    init(favorite: FavoritePlace) {
        self.favorite = favorite
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: favorite.latitude,
                                           longitude: favorite.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [favorite]) { fav in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: fav.latitude, longitude: fav.longitude)) {
                Image(systemName: "mappin.circle.fill")
                    .font(.title)
                    .foregroundColor(.blue)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationTitle(favorite.name ?? "Favorite")
    }
}
