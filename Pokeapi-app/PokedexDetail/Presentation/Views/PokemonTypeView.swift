//
//  PokemonTypeView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

import SwiftUI

struct PokemonTypeView: View {
    @ObservedObject var viewModel: PokemonDetailViewModel

    var body: some View {
        HStack {
            ForEach(viewModel.types, id: \.self) { type in
                Text(type.capitalized)
                    .font(.subheadline)
                    .bold()
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(viewModel.backgroundColor))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }.padding(.top, 50)
    }
}
