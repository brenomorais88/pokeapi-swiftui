//
//  PokemonRepositoryImpl.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 06/06/25.
//

import Foundation

final class PokemonRepositoryImpl: PokemonRepository {
    private let apiService: PokemonAPIServiceProtocol

    init(apiService: PokemonAPIServiceProtocol = PokemonAPIService()) {
        self.apiService = apiService
    }

    func getPokemonList(limit: Int, offset: Int) async throws -> [PokemonViewData] {
        let results = try await apiService.fetchPokemonList(limit: limit, offset: offset)

        // A URL da API contém o ID no final, então podemos extrair ele aqui
        return results.compactMap { item in
            guard let id = Int(item.url.trimmingCharacters(in: CharacterSet(charactersIn: "/")).components(separatedBy: "/").last ?? "") else {
                return nil
            }

            return PokemonViewData(id: id, name: item.name.capitalized)
        }
        .filter { $0.id <= 151 } // apenas os 151 primeiros
    }
}
