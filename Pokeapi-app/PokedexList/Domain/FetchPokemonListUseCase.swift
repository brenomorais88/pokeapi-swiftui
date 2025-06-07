//
//  FetchPokemonListUseCase.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 06/06/25.
//

final class FetchPokemonListUseCase {
    private let repository: PokemonRepository

    init(repository: PokemonRepository = PokemonRepositoryImpl()) {
        self.repository = repository
    }

    func execute(limit: Int, offset: Int) async throws -> [PokemonViewData] {
        try await repository.getPokemonList(limit: limit, offset: offset)
    }
}
