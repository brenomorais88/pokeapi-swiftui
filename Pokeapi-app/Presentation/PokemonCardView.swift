//
//  PokemonCardView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 06/06/25.
//

import SwiftUI

struct PokemonCardView: View {
    let pokemon: PokemonViewData

    var body: some View {
        VStack {
            Text("#\(pokemon.id)")
                .font(.caption)
                .multilineTextAlignment(.trailing)

            AsyncImage(url: pokemon.imageURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)

            Text("\(pokemon.name)")
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}
