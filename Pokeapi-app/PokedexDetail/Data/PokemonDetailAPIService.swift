//
//  PokemonDetailAPIService.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 07/06/25.
//

import Foundation
import Combine

protocol PokemonDetailAPIServiceProtocol {
    func fetchDetails(id: Int) -> AnyPublisher<PokemonDetail, Error>
}

enum PokemonDetailAPIError: Error {
    case invalidURL
    case decodingFailed
}

final class PokemonDetailAPIService: PokemonDetailAPIServiceProtocol {
    func fetchDetails(id: Int) -> AnyPublisher<PokemonDetail, Error> {
        guard let detailURL = makePokemonDetailURL(id: id),
              let speciesURL = makePokemonSpeciesURL(id: id),
              let imageURL = makeImageURL(for: id) else {

            return Fail(error: PokemonDetailAPIError.invalidURL).eraseToAnyPublisher()
        }

        let detailPublisher = URLSession.shared.dataTaskPublisher(for: detailURL)
            .map(\.data)
            .decode(type: PokemonDetailDTO.self, decoder: JSONDecoder())

        let speciesPublisher = URLSession.shared.dataTaskPublisher(for: speciesURL)
            .map(\.data)
            .decode(type: PokemonSpeciesDTO.self, decoder: JSONDecoder())

        return Publishers.Zip(detailPublisher, speciesPublisher)
            .map { detail, species in
                PokemonDetail(
                    id: id,
                    name: detail.name.capitalized,
                    imageURL: imageURL,
                    types: detail.types.map { $0.type.name.capitalized },
                    height: detail.height,
                    weight: detail.weight,
                    moves: detail.moves.prefix(2).map { $0.move.name.capitalized },
                    description: self.extractEnglishDescription(from: species),
                    stats: detail.stats.map {
                        PokemonStat(label: $0.stat.name.uppercased(), value: $0.baseStat)
                    }
                )
            }
            .mapError { _ in PokemonDetailAPIError.decodingFailed }
            .eraseToAnyPublisher()
    }

    // MARK: - Private Helpers
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
