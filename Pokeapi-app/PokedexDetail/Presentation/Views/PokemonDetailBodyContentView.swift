//
//  PokemonDetailBodyContentView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//
import SwiftUI

struct PokemonDetailBodyContentView: View {
    @ObservedObject var viewModel: PokemonDetailViewModel

    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .center, spacing: 16) {
                PokemonTypeView(viewModel: viewModel)
                PokemonAboutSectionView(viewModel: viewModel)
                PokemonDescriptionView(viewModel: viewModel)
                PokemonStatsSectionView(viewModel: viewModel)
            }
            .padding(24)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .ignoresSafeArea(edges: .bottom)
            )
            .padding(.top, 190)
            .zIndex(0)

            VStack(spacing: 8) {
                Image("pokeball-background")
                    .resizable()
                    .frame(width: 208, height: 208)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .offset(y: -40)

                if let imageURL = viewModel.imageURL {
                    AsyncImage(url: imageURL) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 200, height: 200)
                    .offset(y: -190)
                }
            }
            .zIndex(1)
        }
    }
}
