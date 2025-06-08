//
//  PokedexHeaderView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

import SwiftUI

struct PokedexHeaderView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image("pokeball-image-small")
                .resizable()
                .renderingMode(.original)
                .frame(width: 32, height: 32)

            Text(Strings.appTitle)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)

            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 16)
        .background(Constants.colors.primaryColor)
    }
}
