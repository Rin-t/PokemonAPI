//
//  PokemonAPI.swift
//  pokemonAPI
//
//  Created by Rin on 2021/09/06.
//

import Foundation

final class PokemonAPIModel {
    private(set) var pokemonName: String?
    private(set) var pokemonImageData: Data?

    func getPokemonName(id: Int, complition: @escaping () -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("error")
            }

            guard let data = data,
                  response != nil else {
                print("data or response are nil")
                return
            }

            do {
                guard let name = try? JSONDecoder().decode(Pokemon.self, from: data).name else { return }
                guard let image = try? JSONDecoder().decode(Pokemon.self, from: data).sprites else { return }
                let url = URL(string: image.frontImage)
                self.pokemonImageData = try? Data(contentsOf: url!)
                self.pokemonName = name
                print(name)
                print("2")
            }
            complition()
        }
        task.resume()
    }
}
