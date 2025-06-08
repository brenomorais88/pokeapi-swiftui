//
//  PokedexSearchAndSortBarView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

import SwiftUI

struct PokedexSearchAndSortBarView: View {
    @ObservedObject var viewModel: PokedexListViewModel

    var body: some View {
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
}
