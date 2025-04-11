//
//  MapView.swift
//  LocateMe
//
//  Created by Abdul Mubeen Mohammed on 2025-04-11.
//

import SwiftUI
import MapKit

struct MapView: View {
    let place: Place
    @State private var region: MKCoordinateRegion
    @Environment(\.managedObjectContext) var moc
    @State private var showingAlert = false  // State for alert feedback
    
    init(place: Place) {
        self.place = place
        let latitude = Double(place.lat) ?? 0.0
        let longitude = Double(place.lon) ?? 0.0
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Map(coordinateRegion: $region, annotationItems: [place]) { item in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(item.lat) ?? 0.0,
                                                                 longitude: Double(item.lon) ?? 0.0)) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)
                }
            }
            .edgesIgnoringSafeArea(.top)
            
            // "Save to Favorites" button with a green-to-teal gradient.
            Button(action: savePlace) {
                Text("Save to Favorites")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.green, Color.teal]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
            }
        }
        .navigationTitle(place.displayName)
        .alert(isPresented: $showingAlert) {  // Alert modifier for visual feedback.
            Alert(title: Text("Saved!"),
                  message: Text("Place has been saved to your favorites."),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    /// Saves the selected place to Core Data and shows confirmation alert.
    func savePlace() {
        let newFavorite = FavoritePlace(context: moc)
        newFavorite.id = UUID()
        newFavorite.name = place.displayName
        newFavorite.latitude = Double(place.lat) ?? 0.0
        newFavorite.longitude = Double(place.lon) ?? 0.0
        newFavorite.timestamp = Date()
        
        do {
            try moc.save()
            showingAlert = true  // Trigger the alert after a successful save.
        } catch {
            print("Error saving favorite: \(error)")
        }
    }
}
