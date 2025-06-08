//
//  PokedexListViewModelTests.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//


import XCTest
@testable import Pokeapi_app

final class PokedexListViewModelTests: XCTestCase {
    // MARK: - Mock Repository

    final class MockPokemonRepository: PokemonRepository {
        var items: [PokemonItemDTO] = []

        func getPokemonList(limit: Int, offset: Int) async throws -> [PokemonViewData] {
            items = loadPokemonDTOList(from: "pokemon_mock_list")
            return items.compactMap { item in
                guard let id = Int(item.url.split(separator: "/").last ?? "") else { return nil }
                return PokemonViewData(id: id, name: item.name.capitalized)
            }
        }

        private func loadPokemonDTOList(from jsonFile: String) -> [PokemonItemDTO] {
            guard let url = Bundle(for: type(of: self)).url(forResource: jsonFile, withExtension: "json") else {
                fatalError("JSON file not found: \(jsonFile).json")
            }

            do {
                let data = try Data(contentsOf: url)
                let decoded = try JSONDecoder().decode(PokemonListResponseDTO.self, from: data)
                return decoded.results
            } catch {
                fatalError("Failed to decode \(jsonFile).json: \(error)")
            }
        }
    }

    //     MARK: - Helpers

    private func makeUseCase() -> FetchPokemonListUseCase {
        let mock = MockPokemonRepository()
        return FetchPokemonListUseCase(repository: mock)
    }

    // MARK: Tests

    func test_filteredPokemons_filtersByName_usingJSON() async {
        let useCase = makeUseCase()
        let viewModel = PokedexListViewModel(fetchPokemonUseCase: useCase)

        await viewModel.loadNextPage()

        viewModel.searchText = "wee"
        print(viewModel.pokemons)
        let filtered = viewModel.filteredPokemons
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first?.name, "Weedle")
    }

    func test_filteredPokemons_filtersByNumber_usingJSON() async {
        let useCase = makeUseCase()
        let viewModel = PokedexListViewModel(fetchPokemonUseCase: useCase)

        await viewModel.loadNextPage()

        viewModel.searchText = "#1"

        let filtered = viewModel.filteredPokemons
        XCTAssertEqual(filtered.count, 7)
        XCTAssertTrue(filtered.contains { $0.id == 15 })
        XCTAssertTrue(filtered.contains { $0.id == 1 })
    }

    func test_filteredPokemons_sortsByName_usingJSON() async {
        let useCase = makeUseCase()
        let viewModel = PokedexListViewModel(fetchPokemonUseCase: useCase)

        await viewModel.loadNextPage()

        viewModel.sortType = .name
        let sorted = viewModel.filteredPokemons

        XCTAssertEqual(sorted.first?.name, "Beedrill")
        XCTAssertEqual(sorted.last?.name, "Weedle")
    }

    func test_filteredPokemons_sortsByNumber_usingJSON() async {
        let useCase = makeUseCase()
        let viewModel = PokedexListViewModel(fetchPokemonUseCase: useCase)

        await viewModel.loadNextPage()

        viewModel.sortType = .number
        let sorted = viewModel.filteredPokemons

        XCTAssertEqual(sorted.first?.id, 1)
        XCTAssertEqual(sorted.last?.id, 15)
    }
}

