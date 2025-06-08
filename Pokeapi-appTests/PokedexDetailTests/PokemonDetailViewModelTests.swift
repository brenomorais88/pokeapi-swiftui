//
//  PokemonDetailViewModelTests.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

import XCTest
@testable import Pokeapi_app

final class PokemonDetailViewModelTests: XCTestCase {

    final class MockFetchPokemonDetailUseCase: FetchPokemonDetailUseCaseProtocol {
        enum MockError: Error {
            case notImplemented
        }

        var result: Result<PokemonDetail, Error> = .failure(MockError.notImplemented)

        func execute(id: Int) async throws -> PokemonDetail {
            return try result.get()
        }
    }

    func testFetchDetails_ShouldUpdatePublishedValues_WhenUseCaseSucceeds() async {
        let expectedDetail = PokemonDetail(
            id: 1,
            name: "bulbasaur",
            imageURL: URL(string: "https://example.com")!,
            types: ["grass", "poison"],
            height: 7,
            weight: 69,
            moves: ["tackle", "growl"],
            description: "Seed Pokémon",
            stats: [PokemonStat(label: "hp", value: 45)]
        )

        let mockUseCase = MockFetchPokemonDetailUseCase()
        mockUseCase.result = .success(expectedDetail)

        let viewModel = PokemonDetailViewModel(
            id: expectedDetail.id,
            name: expectedDetail.name,
            imageURL: expectedDetail.imageURL,
            fetchUseCase: mockUseCase
        )

        await viewModel.fetchDetails()

        XCTAssertEqual(viewModel.types, expectedDetail.types)
        XCTAssertEqual(viewModel.description, expectedDetail.description)
        XCTAssertEqual(viewModel.weight, "6.9 kg")
        XCTAssertEqual(viewModel.height, "0.7 m")
        XCTAssertEqual(viewModel.moves, ["Tackle", "Growl"])
        XCTAssertEqual(viewModel.stats.count, 1)
        XCTAssertEqual(viewModel.stats.first?.label, "hp")
    }

    func testFetchDetails_ShouldNotCrash_WhenUseCaseFails() async {
        let mockUseCase = MockFetchPokemonDetailUseCase()
        mockUseCase.result = .failure(MockFetchPokemonDetailUseCase.MockError.notImplemented)

        let viewModel = PokemonDetailViewModel(
            id: 1,
            name: "bulbasaur",
            imageURL: nil,
            fetchUseCase: mockUseCase
        )

        await viewModel.fetchDetails()

        XCTAssertEqual(viewModel.types, [])
        XCTAssertEqual(viewModel.description, "")
        XCTAssertEqual(viewModel.weight, "--")
        XCTAssertEqual(viewModel.height, "--")
        XCTAssertEqual(viewModel.moves, [])
    }
}
