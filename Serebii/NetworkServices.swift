//
//  NetworkServices.swift
//  Serebii
//
//  Created by Patrick Solis on 10/30/21.
//

import Foundation
    
public func fetchPokemon<T: Decodable>(fromPath path: String, completion: @escaping (T) -> () = { _ in }) {
    guard let url = URL(string: path) else {
        return
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print(error.localizedDescription)
        } else {
            guard let data = data else {
                print("Unable to retrieve data")
                return
            }
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(model)
            } catch {
                print("Unable to decode Pokemon Data: \(error.localizedDescription)")
            }
        }
    }.resume()
}
