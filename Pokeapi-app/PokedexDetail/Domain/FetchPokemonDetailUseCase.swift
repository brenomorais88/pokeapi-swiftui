//
//  FetchPokemonDetailUseCase.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

import Combine

protocol FetchPokemonDetailUseCaseProtocol {
    func execute(id: Int) -> AnyPublisher<PokemonDetail, Error>
}

final class FetchPokemonDetailUseCase: FetchPokemonDetailUseCaseProtocol {
    private let repository: PokemonDetailRepository

    init(repository: PokemonDetailRepository = PokemonDetailRepositoryImpl()) {
        self.repository = repository
    }

    func execute(id: Int) -> AnyPublisher<PokemonDetail, Error> {
        repository.fetchDetail(for: id)
    }
}
