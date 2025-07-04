//
//  PokemonDetailRepository.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

import Combine

protocol PokemonDetailRepository {
    func fetchDetail(for id: Int) -> AnyPublisher<PokemonDetail, Error>
}
