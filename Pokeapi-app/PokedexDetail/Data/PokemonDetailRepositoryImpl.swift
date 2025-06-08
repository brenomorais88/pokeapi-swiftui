//
//  PokemonDetailRepositoryImpl.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

final class PokemonDetailRepositoryImpl: PokemonDetailRepository {
    private let apiService: PokemonDetailAPIServiceProtocol

    init(apiService: PokemonDetailAPIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchDetail(for id: Int) async throws -> PokemonDetail {
        return try await apiService.fetchDetails(id: id)
    }
}
