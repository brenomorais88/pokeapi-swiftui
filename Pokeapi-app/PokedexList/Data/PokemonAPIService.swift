//
//  PokemonAPIService.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 06/06/25.
//

import Foundation
import Combine

protocol PokemonAPIServiceProtocol {
    func fetchPokemonList(limit: Int, offset: Int) -> AnyPublisher<[PokemonItemDTO], Error>
}

final class PokemonAPIService: PokemonAPIServiceProtocol {
    func fetchPokemonList(limit: Int, offset: Int) -> AnyPublisher<[PokemonItemDTO], Error> {

        guard let url = makeURL(limit: limit, offset: offset) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PokemonListResponseDTO.self, decoder: JSONDecoder())
            .map(\.results)
            .eraseToAnyPublisher()
    }

    private func makeURL(limit: Int, offset: Int) -> URL? {
        URL(string: "\(Constants.API.baseURL)pokemon?limit=\(limit)&offset=\(offset)")
    }
}
