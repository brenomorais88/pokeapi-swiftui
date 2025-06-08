//
//  FetchPokemonDetailUseCaseTests.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

final class MockPokemonDetailRepository: PokemonDetailRepository {
    var expectedDetail: PokemonDetail?

    func fetchDetail(for id: Int) async throws -> PokemonDetail {
        if let detail = expectedDetail {
            return detail
        } else {
            throw NSError(domain: "MockError", code: -1)
        }
    }
}

import XCTest
@testable import Pokeapi_app

final class FetchPokemonDetailUseCaseTests: XCTestCase {

    func testExecute_ShouldReturnPokemonDetail_WhenRepositorySucceeds() async throws {
        let mockRepository = MockPokemonDetailRepository()
        let expectedDetail = PokemonDetail(
            id: 1,
            name: "Bulbasaur",
            imageURL: URL(string: "https://example.com/1.png")!,
            types: ["grass", "poison"],
            height: 7,
            weight: 69,
            moves: ["tackle", "growl"],
            description: "A strange seed was planted on its back at birth.",
            stats: [
                PokemonStat(label: "HP", value: 45),
                PokemonStat(label: "ATK", value: 49)
            ]
        )
        mockRepository.expectedDetail = expectedDetail
        let useCase = FetchPokemonDetailUseCase(repository: mockRepository)

        let result = try await useCase.execute(id: 1)

        XCTAssertEqual(result.id, expectedDetail.id)
        XCTAssertEqual(result.name, expectedDetail.name)
        XCTAssertEqual(result.types, expectedDetail.types)
    }
}
