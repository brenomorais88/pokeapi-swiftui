//
//  PokemonDetailAPIService.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 07/06/25.
//

import Foundation

import Foundation

protocol PokemonDetailAPIServiceProtocol {
    func fetchDetails(id: Int) async throws -> PokemonDetail
}

enum PokemonDetailAPIError: Error {
    case invalidURL
    case decodingFailed
}

final class PokemonDetailAPIService: PokemonDetailAPIServiceProtocol {
    func fetchDetails(id: Int) async throws -> PokemonDetail {
        async let detailDTO = fetchPokemonData(id: id)
        async let speciesDTO = fetchPokemonSpecies(id: id)

        let (detail, species) = try await (detailDTO, speciesDTO)

        guard let imageURL = makeImageURL(for: id) else {
            throw PokemonDetailAPIError.invalidURL
        }

        return PokemonDetail(
            id: id,
            name: detail.name.capitalized,
            imageURL: imageURL,
            types: detail.types.map { $0.type.name.capitalized },
            height: detail.height,
            weight: detail.weight,
            moves: detail.moves.prefix(2).map { $0.move.name.capitalized },
            description: extractEnglishDescription(from: species),
            stats: detail.stats.map {
                PokemonStat(label: $0.stat.name.uppercased(), value: $0.baseStat)
            }
        )
    }

    // MARK: - Private Helpers

    private func fetchPokemonData(id: Int) async throws -> PokemonDetailDTO {
        guard let url = makePokemonDetailURL(id: id) else {
            throw PokemonDetailAPIError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(PokemonDetailDTO.self, from: data)
    }

    private func fetchPokemonSpecies(id: Int) async throws -> PokemonSpeciesDTO {
        guard let url = makePokemonSpeciesURL(id: id) else {
            throw PokemonDetailAPIError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(PokemonSpeciesDTO.self, from: data)
    }

    private func makePokemonDetailURL(id: Int) -> URL? {
        URL(string: "\(Constants.API.baseURL)pokemon/\(id)")
    }

    private func makePokemonSpeciesURL(id: Int) -> URL? {
        URL(string: "\(Constants.API.baseURL)pokemon-species/\(id)")
    }

    private func makeImageURL(for id: Int) -> URL? {
        URL(string: "\(Constants.URLs.baseImageURL)\(id).png")
    }

    private func extractEnglishDescription(from species: PokemonSpeciesDTO) -> String {
        species.flavorTextEntries
            .first(where: { $0.language.name == "en" })?
            .flavorText
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\u{0C}", with: " ")
            ?? ""
    }
}
