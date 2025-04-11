//
//  SearchViewModel.swift
//  LocateMe
//
//  Created by Abdul Mubeen Mohammed on 2025-04-11.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var places: [Place] = []
    
    func search() {
        guard !query.isEmpty else { return }
        // Percent-encode the query
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let urlString = "https://nominatim.openstreetmap.org/search?q=\(encodedQuery)&format=json"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode([Place].self, from: data)
                DispatchQueue.main.async {
                    self?.places = results
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
