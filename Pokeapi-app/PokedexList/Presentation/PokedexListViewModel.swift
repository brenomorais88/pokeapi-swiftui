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
    @Published var isLoading: Bool = false

    private var currentOffset = 0
    private let limit = 15
    private let maxPokemonID = 151

    private let fetchPokemonUseCase = FetchPokemonListUseCase()

    init() {
        Task {
            await loadNextPage()
        }
    }

    var filteredPokemons: [PokemonViewData] {
        let trimmedSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let cleanedSearch = trimmedSearch.replacingOccurrences(of: "#", with: "")

        let filtered: [PokemonViewData]

        if cleanedSearch.isEmpty {
            filtered = pokemons
        } else {
            filtered = pokemons.filter { pokemon in
                let idString = String(pokemon.id)
                let paddedId = String(format: "%03d", pokemon.id)

                return pokemon.name.lowercased().contains(cleanedSearch)
                    || idString.contains(cleanedSearch)
                    || paddedId.contains(cleanedSearch)
            }
        }

        switch sortType {
        case .number:
            return filtered.sorted { $0.id < $1.id }
        case .name:
            return filtered.sorted { $0.name < $1.name }
        }
    }

    @MainActor
    func loadNextPage() async {
        guard !isLoading else { return }
        guard pokemons.last?.id ?? 0 < maxPokemonID else { return }

        isLoading = true
        do {
            let newPokemons = try await fetchPokemonUseCase.execute(limit: limit, offset: currentOffset)
            pokemons.append(contentsOf: newPokemons)
            currentOffset += limit
        } catch {
            print("Error loading Pokémon: \(error)")
        }
        isLoading = false
    }
}
