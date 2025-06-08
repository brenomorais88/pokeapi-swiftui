//
//  PokemonAboutSectionView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

import SwiftUI

struct PokemonAboutSectionView: View {
    @ObservedObject var viewModel: PokemonDetailViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text(Strings.about)
                .font(.headline)
                .foregroundColor(Color(viewModel.backgroundColor))
                .bold()

            HStack(alignment: .bottom) {
                VStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Image("weight-icon")
                        Text(viewModel.weight)
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    Text(Strings.weight)
                        .font(.caption)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)

                Divider().frame(height: 40)

                VStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Image("height-icon")
                        Text(viewModel.height)
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    Text(Strings.height)
                        .font(.caption)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)

                Divider().frame(height: 40)

                VStack(spacing: 8) {
                    Text(viewModel.moves.joined(separator: "\n"))
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                    Text(Strings.moves)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .frame(height: 130)
    }
}
