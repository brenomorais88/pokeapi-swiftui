//
//  PokemonAPIService.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 06/06/25.
//

import Foundation

protocol PokemonAPIServiceProtocol {
    func fetchPokemonList(limit: Int, offset: Int) async throws -> [PokemonItemDTO]
}

final class PokemonAPIService: PokemonAPIServiceProtocol {
    func fetchPokemonList(limit: Int, offset: Int) async throws -> [PokemonItemDTO] {
        guard let url = URL(string: "\(Constants.API.baseURL)pokemon?limit=\(limit)&offset=\(offset)") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(PokemonListResponseDTO.self, from: data)
        return decoded.results
    }
}
