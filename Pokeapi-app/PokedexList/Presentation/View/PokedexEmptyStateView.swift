//
//  PokedexEmptyStateView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

import SwiftUI

struct PokedexEmptyStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(.white)

            Text(Strings.noResults)
                .font(.headline)
                .foregroundColor(.white)

            Text(Strings.tryWithAnotherParam)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
    }
}
