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

class PokedexListViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var pokemons: [PokemonViewData] = []
    @Published var searchText: String = ""
    @Published var sortType: SortType = .number
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    // MARK: - Private Properties

    private var currentOffset = 0
    private let limit = 15
    private let maxPokemonID = 151
    private let fetchPokemonUseCase: FetchPokemonListUseCaseProtocol

    // MARK: - Init

    init(fetchPokemonUseCase: FetchPokemonListUseCaseProtocol = FetchPokemonListUseCase()) {
        self.fetchPokemonUseCase = fetchPokemonUseCase
        Task {
            await loadNextPage()
        }
    }

    // MARK: - Computed

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

    // MARK: - Public Methods

    @MainActor
    func loadNextPage() async {
        guard !isLoading else { return }
        guard pokemons.last?.id ?? 0 < maxPokemonID else { return }

        isLoading = true
        errorMessage = nil

        do {
            let newPokemons = try await fetchPokemonUseCase.execute(limit: limit, offset: currentOffset)
            pokemons.append(contentsOf: newPokemons)
            currentOffset += limit
        } catch {
            errorMessage = "Failed to load Pokémon. Please try again."
        }

        isLoading = false
    }

    func toggleSortType() {
        sortType = sortType == .number ? .name : .number
    }
}
