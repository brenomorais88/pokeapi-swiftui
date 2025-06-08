//
//  PokedexCoordinator.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

import SwiftUI

final class PokedexCoordinator {
    func pokemonDetail(for pokemon: PokemonViewData) -> some View {
        let apiService = PokemonDetailAPIService()
        let repository = PokemonDetailRepositoryImpl(apiService: apiService)
        let useCase = FetchPokemonDetailUseCase(repository: repository)
        let viewModel = PokemonDetailViewModel(
            id: pokemon.id,
            name: pokemon.name,
            imageURL: pokemon.imageURL,
            fetchUseCase: useCase
        )
        return PokemonDetailView(viewModel: viewModel)
    }
}
