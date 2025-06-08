//
//  PokemonDetailRepository.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

protocol PokemonDetailRepository {
    func fetchDetail(for id: Int) async throws -> PokemonDetail
}
