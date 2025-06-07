//
//  PokemonRepository.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 06/06/25.
//

protocol PokemonRepository {
    func getPokemonList(limit: Int, offset: Int) async throws -> [PokemonViewData]
}
