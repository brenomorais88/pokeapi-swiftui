//
//  FetchPokemonListUseCase.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 06/06/25.
//

protocol FetchPokemonListUseCaseProtocol {
    func execute(limit: Int, offset: Int) async throws -> [PokemonViewData]
}

final class FetchPokemonListUseCase: FetchPokemonListUseCaseProtocol {
    private let repository: PokemonRepository

    init(repository: PokemonRepository = PokemonRepositoryImpl()) {
        self.repository = repository
    }

    func execute(limit: Int, offset: Int) async throws -> [PokemonViewData] {
        try await repository.getPokemonList(limit: limit, offset: offset)
    }
}
