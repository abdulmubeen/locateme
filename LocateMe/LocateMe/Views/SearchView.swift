//
//  SearchView.swift
//  LocateMe
//
//  Created by Abdul Mubeen Mohammed on 2025-04-11.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // TextField with a light pastel blue background.
                TextField("Enter city name", text: $viewModel.query, onCommit: {
                    viewModel.search()
                })
                .padding()
                .background(Color(red: 0.9, green: 0.95, blue: 1.0))
                .cornerRadius(12)
                .font(.system(size: 16, weight: .medium))
                .padding(.horizontal)
                
                // Search button with a purple-to-pink gradient.
                Button(action: {
                    viewModel.search()
                }) {
                    Text("Search")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]),
                                           startPoint: .leading,
                                           endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                
                // Search results list.
                List(viewModel.places) { place in
                    NavigationLink(destination: MapView(place: place)) {
                        Text(place.displayName)
                            .font(.system(size: 15))
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
                            )
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(PlainListStyle())
            }
            .padding(.top)
            // A subtle gradient background for the overall screen.
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.95, green: 0.95, blue: 1.0)]),
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
            )
            .navigationTitle("LocateMe")
        }
    }
}
