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
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                Spacer().frame(height: 24)
                AsyncImage(url: pokemon.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                } placeholder: {
                    ProgressView()
                        .frame(height: 100)
                }
                Text(pokemon.name)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color(white: 0.95))
            }
            Text(String(format: "#%03d", pokemon.id))
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, 8)
                .padding(.trailing, 8)
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    PokemonCardView(pokemon: PokemonViewData(id: 10, name: "Pikachu"))
}
