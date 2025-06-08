//
//  FetchPokemonDetailUseCase.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

final class FetchPokemonDetailUseCase {
    private let repository: PokemonDetailRepository

    init(repository: PokemonDetailRepository) {
        self.repository = repository
    }

    func execute(id: Int) async throws -> PokemonDetail {
        return try await repository.fetchDetail(for: id)
    }
}
