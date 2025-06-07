//
//  PokedexListView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 06/06/25.
//

import SwiftUI

struct PokedexListView: View {
    @StateObject private var viewModel = PokedexListViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                header
                searchAndSortBar
                pokemonGrid
            }
            .navigationBarHidden(true)
        }
    }

    private var header: some View {
        Text(Strings.appTitle)
            .font(.largeTitle).bold()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
    }

    private var searchAndSortBar: some View {
        HStack(spacing: 12) {
            TextField(Strings.searchPlaceholder,
                      text: $viewModel.searchText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)

            Menu {
                Picker(Strings.sortBy, selection: $viewModel.sortType) {
                    Text(Strings.sortByNumber)
                        .tag(SortType.number)
                    Text(Strings.sortByName)
                        .tag(SortType.name)
                }
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(.gray)

            Text(Strings.noResults)
                .font(.headline)
                .foregroundColor(.gray)

            Text(Strings.tryWithAnotherParam)
                .font(.subheadline)
                .foregroundColor(.gray.opacity(0.7))
        }
        .padding()
    }

    private var errorState: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48))
                .foregroundColor(.orange)

            Text(viewModel.errorMessage ?? Strings.unknownError)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)

            Button(Strings.tryAgain) {
                Task { await viewModel.loadNextPage() }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 10)
            .background(Color.red.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }

    private var pokemonGrid: some View {
        Group {
            if viewModel.errorMessage != nil {
                VStack {
                    Spacer()
                    errorState
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.filteredPokemons.isEmpty && !viewModel.searchText.isEmpty {
                VStack {
                    Spacer()
                    emptyState
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                        ForEach(viewModel.filteredPokemons) { pokemon in
                            NavigationLink(
                                destination: PokemonDetailView(
                                    viewModel: PokemonDetailViewModel(
                                        id: pokemon.id,
                                        name: pokemon.name,
                                        imageURL: pokemon.imageURL
                                    )
                                )
                            ) {
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
        }
    }

}

#Preview {
    PokedexListView()
}

