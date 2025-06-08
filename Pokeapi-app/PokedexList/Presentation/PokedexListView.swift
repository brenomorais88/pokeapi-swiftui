//
//  PokedexListView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 06/06/25.
//

import SwiftUI

struct PokedexListView: View {
    @StateObject private var viewModel = PokedexListViewModel()
    private let coordinator = PokedexCoordinator()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                header
                searchAndSortBar
                pokemonGridView
            }
            .navigationBarHidden(true)
            .background(Constants.colors.primaryColor)
        }
    }

    private var header: some View {
        HStack(alignment: .center, spacing: 12) {
            Image("pokeball-image-small")
                .resizable()
                .renderingMode(.original)
                .frame(width: 32, height: 32)

            Text(Strings.appTitle)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)

            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 16)
        .background(Constants.colors.primaryColor)
    }

    private var searchAndSortBar: some View {
        HStack(spacing: 12) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.red)

                TextField(Strings.searchPlaceholder, text: $viewModel.searchText)
                    .foregroundColor(.primary)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(40)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)

            Menu {
                Picker(Strings.sortBy, selection: $viewModel.sortType) {
                    Text(Strings.sortByNumber).tag(SortType.number)
                    Text(Strings.sortByName).tag(SortType.name)
                }
            } label: {
                Image(viewModel.sortType == .number ? "sort-number" : "sort-text")
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 35, height: 35)
                    .background(
                        Circle()
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    )
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Constants.colors.primaryColor)
    }


    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(.white)

            Text(Strings.noResults)
                .font(.headline)
                .foregroundColor(.white)

            Text(Strings.tryWithAnotherParam)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
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

    private var pokemonGridView: some View {
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
                pokemonGridContainer
            }
        }
    }

    private var pokemonGridContainer: some View {
        VStack {
            pokemonGrid
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

    private var pokemonGrid: some View {
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
}

#Preview {
    PokedexListView()
}

