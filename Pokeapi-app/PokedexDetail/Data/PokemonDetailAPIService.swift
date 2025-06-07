//
//  PokemonDetailAPIService.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 07/06/25.
//

import Foundation

final class PokemonDetailAPIService {
    func fetchDetails(id: Int) async throws -> PokemonDetail {
        async let detailData = fetchPokemonData(id: id)
        async let speciesData = fetchPokemonSpecies(id: id)

        let (detail, species) = try await (detailData, speciesData)

        return PokemonDetail(
            id: id,
            name: detail.name,
            imageURL: URL(string: Constants.URLs.baseImageURL + "\(id).png")!,
            types: detail.types.map { $0.type.name },
            height: detail.height,
            weight: detail.weight,
            moves: detail.moves.prefix(2).map { $0.move.name },
            description: species.flavorTextEntries
                .first(where: { $0.language.name == "en" })?.flavorText
                .replacingOccurrences(of: "\n", with: " ")
                .replacingOccurrences(of: "\u{0C}", with: " ") ?? "",
            stats: detail.stats.map {
                PokemonStat(label: $0.stat.name.uppercased(), value: $0.baseStat)
            }
        )
    }

    // MARK: - Private Helpers

    private func fetchPokemonData(id: Int) async throws -> PokemonDetailDTO {
        let url = URL(string: "\(Constants.API.baseURL)pokemon/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(PokemonDetailDTO.self, from: data)
    }

    private func fetchPokemonSpecies(id: Int) async throws -> PokemonSpeciesDTO {
        let url = URL(string: "\(Constants.API.baseURL)pokemon-species/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(PokemonSpeciesDTO.self, from: data)
    }
}
