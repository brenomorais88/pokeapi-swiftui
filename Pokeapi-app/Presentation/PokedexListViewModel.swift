//
//  PokedexListViewModel.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 06/06/25.
//

import SwiftUI

enum SortType {
    case number
    case name
}

final class PokedexListViewModel: ObservableObject {
    @Published var pokemons: [PokemonViewData] = []
    @Published var searchText: String = ""
    @Published var sortType: SortType = .number

    init() {
        loadMockPokemons()
    }

    var filteredPokemons: [PokemonViewData] {
        let filtered = searchText.isEmpty
            ? pokemons
            : pokemons.filter { $0.name.localizedCaseInsensitiveContains(searchText) }

        switch sortType {
        case .number:
            return filtered.sorted { $0.id < $1.id }
        case .name:
            return filtered.sorted { $0.name < $1.name }
        }
    }

    private func loadMockPokemons() {
        pokemons = [
            .init(id: 1, name: "Bulbasaur"),
            .init(id: 4, name: "Charmander"),
            .init(id: 7, name: "Squirtle"),
            .init(id: 10, name: "Caterpie"),
            .init(id: 25, name: "Pikachu"),
            .init(id: 133, name: "Eevee"),
            .init(id: 150, name: "Mewtwo"),
            .init(id: 151, name: "Mew"),
            .init(id: 92, name: "Gastly")
        ]
    }
}
