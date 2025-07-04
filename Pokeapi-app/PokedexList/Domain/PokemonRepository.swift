//
//  PokemonRepository.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 06/06/25.
//

import Combine

protocol PokemonRepository {
    func getPokemonList(limit: Int, offset: Int) -> AnyPublisher<[PokemonViewData], Error>
}
