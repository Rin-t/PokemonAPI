//
//  PokemonAPI.swift
//  pokemonAPI
//
//  Created by Rin on 2021/09/06.
//

import Foundation

final class PokemonAPIModel {
    static func getPokemonName(id: Int, complitionHandler: @escaping (String, Data?) -> Void) {
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
                let data = try? Data(contentsOf: url!)

                complitionHandler(name, data)
            }
        }
        task.resume()
    }
}
