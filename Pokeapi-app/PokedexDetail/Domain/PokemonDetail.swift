//
//  PokemonDetail.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 07/06/25.
//

import Foundation

struct PokemonDetail {
    let id: Int
    let name: String
    let imageURL: URL
    let types: [String]
    let height: Int
    let weight: Int
    let moves: [String]
    let description: String
    let stats: [PokemonStat]
}

struct PokemonStat {
    let label: String
    let value: Int
}
