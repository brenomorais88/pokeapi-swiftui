//
//  PokemonViewData.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 06/06/25.
//

import Foundation

struct PokemonViewData: Identifiable {
    let id: Int
    let name: String

    var imageURL: URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(id).png")
    }
}
