//
//  PokemonDetailView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 07/06/25.
//

import SwiftUI

import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject var viewModel: PokemonDetailViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color(viewModel.backgroundColor)
                    .ignoresSafeArea()
                PokemonDetailHeaderView(viewModel: viewModel, dismiss: dismiss)
                    .frame(width: geometry.size.width)
                    .zIndex(1)
                ScrollView {
                    VStack(spacing: 16) {
                        PokemonDetailBodyContentView(viewModel: viewModel)
                    }
                    .padding()
                    .padding(.top, 48)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchDetails()
            }
        }
        .navigationBarHidden(true)
    }
}
