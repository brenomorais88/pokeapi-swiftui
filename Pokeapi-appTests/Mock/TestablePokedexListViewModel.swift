//
//  FetchPokemonListUseCaseTests.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 07/06/25.
//

import XCTest
@testable import Pokeapi_app

import SwiftUI

//final class MockPokemonRepository: PokemonRepository {
//    private let items: [PokemonItemDTO]
//
//    init(items: [PokemonItemDTO]) {
//        self.items = items
//    }
//
//    func getPokemonList(limit: Int, offset: Int) async throws -> [PokemonViewData] {
//        return items.compactMap { dto in
//            guard let id = Int(dto.url.split(separator: "/").last ?? "") else { return nil }
//            return PokemonViewData(id: id, name: dto.name.capitalized)
//        }
//    }
//}
