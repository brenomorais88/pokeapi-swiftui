//
//  FetchPokemonListUseCase.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 06/06/25.
//

import Combine

protocol FetchPokemonListUseCaseProtocol {
    func execute(limit: Int, offset: Int) -> AnyPublisher<[PokemonViewData], Error>
}

final class FetchPokemonListUseCase: FetchPokemonListUseCaseProtocol {
    private let repository: PokemonRepository

    init(repository: PokemonRepository = PokemonRepositoryImpl()) {
        self.repository = repository
    }

    func execute(limit: Int, offset: Int) -> AnyPublisher<[PokemonViewData], Error> {
        repository.getPokemonList(limit: limit, offset: offset)
    }
}
