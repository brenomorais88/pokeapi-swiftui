//
//  PokemonDetailViewModel.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 07/06/25.
//

import SwiftUI
import Combine

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
    @Published var isLoading: Bool = false
    @Published var hasError: Bool = false
    @Published var errorMessage: String = ""

    private let fetchUseCase: FetchPokemonDetailUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

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
        await MainActor.run {
            isLoading = true
            hasError = false
            errorMessage = ""
        }

        fetchUseCase.execute(id: id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                if case .failure(_) = completion {
                    self.hasError = true
                    self.errorMessage = Strings.failedLoadDetails
                }
            } receiveValue: { [weak self] detail in
                guard let self = self else { return }
                self.types = detail.types
                self.weight = "\(Double(detail.weight) / 10.0) kg"
                self.height = "\(Double(detail.height) / 10.0) m"
                self.moves = detail.moves.prefix(2).map { $0.capitalized }
                self.description = detail.description
                self.stats = detail.stats.map {
                    PokemonStatViewData(label: $0.label,
                                        value: $0.value,
                                        statsLabel: self.mapStatsLabel($0.label))
                }

            }.store(in: &cancellables)

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
