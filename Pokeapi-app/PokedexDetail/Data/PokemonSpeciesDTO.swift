//
//  PokemonSpeciesDTO.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 07/06/25.
//

struct PokemonSpeciesDTO: Decodable {
    struct FlavorTextEntry: Decodable {
        let flavorText: String
        let language: NamedAPIResource

        enum CodingKeys: String, CodingKey {
            case flavorText = "flavor_text"
            case language
        }
    }

    let flavorTextEntries: [FlavorTextEntry]

    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
}
