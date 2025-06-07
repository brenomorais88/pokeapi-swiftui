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

    private var pokemonGrid: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                ForEach(viewModel.filteredPokemons) { pokemon in
                    PokemonCardView(pokemon: pokemon)
                }
            }
            .padding()
        }
    }
}

#Preview {
    PokedexListView()
}

