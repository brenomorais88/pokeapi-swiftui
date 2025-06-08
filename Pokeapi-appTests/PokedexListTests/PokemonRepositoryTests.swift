//
//  PokemonRepositoryTests.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 07/06/25.
//

import XCTest
@testable import Pokeapi_app

final class PokemonRepositoryTests: XCTestCase {

    // MARK: - Mock Service

    final class MockPokemonAPIService: PokemonAPIServiceProtocol {
        var result: Result<[PokemonItemDTO], Error> = .success([])

        func fetchPokemonList(limit: Int, offset: Int) async throws -> [PokemonItemDTO] {
            try result.get()
        }
    }

    // MARK: - Helpers

    private func makeRepository(with result: Result<[PokemonItemDTO], Error>) -> PokemonRepositoryImpl {
        let mockService = MockPokemonAPIService()
        mockService.result = result
        return PokemonRepositoryImpl(apiService: mockService)
    }

    // MARK: - Tests

    func test_getPokemonList_successfully_returns_valid_pokemon() async throws {
        let dtos = [
            PokemonItemDTO(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
            PokemonItemDTO(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/"),
            PokemonItemDTO(name: "mew", url: "https://pokeapi.co/api/v2/pokemon/151/")
        ]
        let repo = makeRepository(with: .success(dtos))

        let result = try await repo.getPokemonList(limit: 15, offset: 0)
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0].id, 1)
        XCTAssertEqual(result[1].name, "Pikachu")
        XCTAssertEqual(result[2].id, 151)
    }

    func test_getPokemonList_ignores_pokemon_with_invalid_url() async throws {
        let dtos = [PokemonItemDTO(name: "missingno", url: "/pokemon/abc/")]
        let repo = makeRepository(with: .success(dtos))

        let result = try await repo.getPokemonList(limit: 15, offset: 0)

        XCTAssertTrue(result.isEmpty)
    }

    func test_getPokemonList_ignores_pokemon_with_id_greater_than_151() async throws {
        let dtos = [
            PokemonItemDTO(name: "lugia", url: "https://pokeapi.co/api/v2/pokemon/249/"),
            PokemonItemDTO(name: "celebi", url: "https://pokeapi.co/api/v2/pokemon/251/")
        ]
        let repo = makeRepository(with: .success(dtos))

        let result = try await repo.getPokemonList(limit: 15, offset: 0)

        XCTAssertTrue(result.isEmpty)
    }

    func test_getPokemonList_capitalizes_names() async throws {
        let dtos = [
            PokemonItemDTO(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/")
        ]
        let repo = makeRepository(with: .success(dtos))

        let result = try await repo.getPokemonList(limit: 15, offset: 0)

        XCTAssertEqual(result.first?.name, "Pikachu")
    }

    func test_getPokemonList_throws_when_service_fails() async {
        let error = URLError(.badURL)
        let repo = makeRepository(with: .failure(error))

        do {
            _ = try await repo.getPokemonList(limit: 15, offset: 0)
            XCTFail("Expected to throw error")
        } catch {
            XCTAssertEqual(error as? URLError, URLError(.badURL))
        }
    }
}
