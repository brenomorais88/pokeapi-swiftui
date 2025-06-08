//
//  FetchPokemonListUseCaseTests.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 07/06/25.
//

import XCTest
@testable import Pokeapi_app

final class FetchPokemonListUseCaseTests: XCTestCase {

    // MARK: - Mock Repository

    final class MockPokemonRepository: PokemonRepository {
        var result: Result<[PokemonViewData], Error> = .success([])

        func getPokemonList(limit: Int, offset: Int) async throws -> [PokemonViewData] {
            try result.get()
        }
    }

    // MARK: - Helpers

    private func makeUseCase(with result: Result<[PokemonViewData], Error>) -> FetchPokemonListUseCase {
        let mock = MockPokemonRepository()
        mock.result = result
        return FetchPokemonListUseCase(repository: mock)
    }

    // MARK: - Tests

    func test_execute_returnsPokemonList() async throws {
        let expected = [
            PokemonViewData(id: 1, name: "Bulbasaur"),
            PokemonViewData(id: 4, name: "Charmander")
        ]
        let useCase = makeUseCase(with: .success(expected))
        let result = try await useCase.execute(limit: 10, offset: 0)
        XCTAssertEqual(result, expected)
    }

    func test_execute_throwsErrorFromRepository() async {
        let useCase = makeUseCase(with: .failure(URLError(.notConnectedToInternet)))

        do {
            _ = try await useCase.execute(limit: 10, offset: 0)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}
