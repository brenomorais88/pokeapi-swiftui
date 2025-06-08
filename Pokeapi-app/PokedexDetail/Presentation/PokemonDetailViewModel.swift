//
//  PokemonDetailViewModel.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 07/06/25.
//

import SwiftUI

final class PokemonDetailViewModel: ObservableObject {
    let id: Int
    let name: String
    let imageURL: URL?

    @Published var types: [String] = []
    @Published var weight: String = "--"
    @Published var height: String = "--"
    @Published var moves: [String] = []
    @Published var description: String = ""
    @Published var stats: [PokemonStatViewData] = []

    private let fetchUseCase: FetchPokemonDetailUseCaseProtocol

    var backgroundColor: Color {
        guard let mainType = types.first?.lowercased() else {
            return .gray
        }
        return PokemonTypeColor.color(for: mainType)
    }

    init(id: Int, name: String, imageURL: URL?, fetchUseCase: FetchPokemonDetailUseCaseProtocol = FetchPokemonDetailUseCase()) {
        self.id = id
        self.name = name.capitalized
        self.imageURL = imageURL
        self.fetchUseCase = fetchUseCase
    }

    func fetchDetails() async {
        do {
            let details = try await fetchUseCase.execute(id: id)

            await MainActor.run {
                types = details.types
                weight = "\(Double(details.weight) / 10.0) kg"
                height = "\(Double(details.height) / 10.0) m"
                moves = details.moves.prefix(2).map { $0.capitalized }
                description = details.description
                stats = details.stats.map {
                    PokemonStatViewData(label: $0.label,
                                        value: $0.value,
                                        statsLabel: mapStatsLabel($0.label))
                }
            }

        } catch {
            print("Erro ao carregar detalhes: \(error)")
        }
    }

    private func mapStatsLabel(_ label: String) -> String {
        let mapping: [String: String] = [
            "hp": "HP",
            "attack": "ATK",
            "defense": "DEF",
            "special-attack": "SATK",
            "special-defense": "SDEF",
            "speed": "SPD"
        ]
        return mapping[label.lowercased()] ?? label.capitalized
    }
}
