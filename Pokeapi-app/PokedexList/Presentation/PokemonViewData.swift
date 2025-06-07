//
//  PokemonViewData.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 06/06/25.
//

import Foundation

struct PokemonViewData: Identifiable, Equatable {
    let id: Int
    let name: String

    var imageURL: URL? {
        URL(string: "\(Constants.URLs.baseImageURL)\(id).png")
    }

    static func == (lhs: PokemonViewData, rhs: PokemonViewData) -> Bool {
        lhs.id == rhs.id
    }
}
