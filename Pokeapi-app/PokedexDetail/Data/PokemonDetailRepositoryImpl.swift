//
//  PokemonDetailRepositoryImpl.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

import Combine

final class PokemonDetailRepositoryImpl: PokemonDetailRepository {
    private let apiService: PokemonDetailAPIServiceProtocol

    init(apiService: PokemonDetailAPIServiceProtocol = PokemonDetailAPIService()) {
        self.apiService = apiService
    }

    func fetchDetail(for id: Int) -> AnyPublisher<PokemonDetail, Error> {
        apiService.fetchDetails(id: id)
    }
}
