//
//  PokemonDescriptionView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

import SwiftUI

struct PokemonDescriptionView: View {
    @ObservedObject var viewModel: PokemonDetailViewModel

    var body: some View {
        Text(viewModel.description)
            .foregroundColor(.black)
            .font(.system(size: 16))
            .multilineTextAlignment(.leading)
            .padding(.top)
    }
}
