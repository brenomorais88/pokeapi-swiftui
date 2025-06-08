//
//  PokemonDetailHeaderView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

import SwiftUI

struct PokemonDetailHeaderView: View {
    @ObservedObject var viewModel: PokemonDetailViewModel
    let dismiss: DismissAction

    var body: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image("back-button")
                    .font(.title2)
                    .foregroundColor(.white)
            }

            Text(viewModel.name)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)

            Spacer()

            Text("#\(String(format: "%03d", viewModel.id))")
                .foregroundColor(.white)
                .bold()
        }
        .background(.clear)
        .padding(16)
    }
}
