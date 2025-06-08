//
//  PokemonDetailRepositoryTests.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

import XCTest
@testable import Pokeapi_app

final class MockPokemonDetailAPIService: PokemonDetailAPIServiceProtocol {
    var result: Result<PokemonDetail, Error> = .failure(MockError.notImplemented)

    enum MockError: Error {
        case notImplemented
    }

    func fetchDetails(id: Int) async throws -> PokemonDetail {
        return try result.get()
    }
}

final class PokemonDetailRepositoryTests: XCTestCase {

    func testFetchDetail_ShouldReturnPokemonDetail_WhenServiceSucceeds() async throws {
        let expected = PokemonDetail(
            id: 25,
            name: "Pikachu",
            imageURL: URL(string: "https://example.com/pikachu.png")!,
            types: ["electric"],
            height: 4,
            weight: 60,
            moves: ["thunderbolt"],
            description: "Pikachu is an Electric-type Pokémon.",
            stats: [PokemonStat(label: "HP", value: 35)]
        )

        let mockService = MockPokemonDetailAPIService()
        mockService.result = .success(expected)

        let repository = PokemonDetailRepositoryImpl(apiService: mockService)

        let detail = try await repository.fetchDetail(for: 25)

        XCTAssertEqual(detail.name, "Pikachu")
        XCTAssertEqual(detail.id, 25)
        XCTAssertEqual(detail.types.first, "electric")
    }

    func testFetchDetail_ShouldThrowError_WhenServiceFails() async {
        let mockService = MockPokemonDetailAPIService()
        mockService.result = .failure(MockPokemonDetailAPIService.MockError.notImplemented)
        let repository = PokemonDetailRepositoryImpl(apiService: mockService)

        do {
            _ = try await repository.fetchDetail(for: 999)
            XCTFail("Expected error, but succeeded")
        } catch {
            XCTAssertTrue(error is MockPokemonDetailAPIService.MockError)
        }
    }
}
