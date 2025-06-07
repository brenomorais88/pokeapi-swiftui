//
//  PokemonListResponseDTO.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 06/06/25.
//

import Foundation

struct PokemonListResponseDTO: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonItemDTO]
}

struct PokemonItemDTO: Decodable {
    let name: String
    let url: String
}
