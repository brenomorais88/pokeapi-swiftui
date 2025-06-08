//
//  PokemonDetailDTO.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 07/06/25.
//

struct PokemonDetailDTO: Decodable {
    struct StatEntry: Decodable {
        let baseStat: Int
        let stat: NamedAPIResource

        enum CodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case stat
        }
    }

    struct TypeEntry: Decodable {
        let type: NamedAPIResource
    }

    struct MoveEntry: Decodable {
        let move: NamedAPIResource
    }

    let name: String
    let height: Int
    let weight: Int
    let types: [TypeEntry]
    let moves: [MoveEntry]
    let stats: [StatEntry]
}
