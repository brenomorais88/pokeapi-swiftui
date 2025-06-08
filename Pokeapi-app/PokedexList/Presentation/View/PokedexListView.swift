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
                PokedexHeaderView()
                PokedexSearchAndSortBarView(viewModel: viewModel)
                PokedexGridView(viewModel: viewModel, coordinator: coordinator)
            }
            .navigationBarHidden(true)
            .background(Constants.colors.primaryColor)
        }
    }
}

