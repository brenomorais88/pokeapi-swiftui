//
//  PokedexErrorStateView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

import SwiftUI

struct PokedexErrorStateView: View {
    let errorMessage: String
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48))
                .foregroundColor(.orange)

            Text(errorMessage)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)

            Button(Strings.tryAgain, action: retryAction)
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                .background(Color.red.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
    }
}
