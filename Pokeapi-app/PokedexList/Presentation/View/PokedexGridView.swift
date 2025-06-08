//
//  PokedexGridView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

import SwiftUI

struct PokedexGridView: View {
    @ObservedObject var viewModel: PokedexListViewModel
    let coordinator: PokedexCoordinator

    var body: some View {
        Group {
            if viewModel.errorMessage != nil {
                VStack {
                    Spacer()
                    PokedexErrorStateView(errorMessage: viewModel.errorMessage ?? Strings.unknownError) {
                        Task { await viewModel.loadNextPage() }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            } else if viewModel.filteredPokemons.isEmpty && !viewModel.searchText.isEmpty {
                VStack {
                    Spacer()
                    PokedexEmptyStateView()
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            } else {
                VStack {
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                            ForEach(viewModel.filteredPokemons) { pokemon in
                                NavigationLink(destination: coordinator.pokemonDetail(for: pokemon)) {
                                    PokemonCardView(pokemon: pokemon)
                                        .onAppear {
                                            if pokemon == viewModel.filteredPokemons.last {
                                                Task { await viewModel.loadNextPage() }
                                            }
                                        }
                                }
                            }
                        }
                        .padding()

                        if viewModel.isLoading {
                            ProgressView(Strings.loading)
                                .padding()
                        }
                    }
                }
                .padding(8)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red, lineWidth: 0)
                )
                .padding(.horizontal, 8)
                .padding(.bottom, 0)
            }
        }
    }
}
