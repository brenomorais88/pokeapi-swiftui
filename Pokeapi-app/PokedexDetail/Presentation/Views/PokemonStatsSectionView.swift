//
//  PokemonStatsSectionView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 08/06/25.
//

import SwiftUI

struct PokemonStatsSectionView: View {
    @ObservedObject var viewModel: PokemonDetailViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(Strings.baseStats)
                .font(.headline)
                .foregroundColor(Color(viewModel.backgroundColor))
                .bold()
                .padding(.bottom, 16)

            ForEach(viewModel.stats, id: \.label) { stat in
                HStack {
                    Text(stat.statsLabel)
                        .frame(width: 35, alignment: .trailing)
                        .foregroundColor(Color(viewModel.backgroundColor))
                        .font(.system(size: 12))
                        .bold()

                    Divider().frame(height: 20)

                    Text(String(format: "%03d", stat.value))
                        .frame(width: 30, alignment: .leading)
                        .foregroundColor(.black)
                        .font(.system(size: 12))

                    ProgressView(value: min(max(Float(stat.value) / 255.0, 0.0), 1.0))
                        .tint(Color(viewModel.backgroundColor))
                }
            }
        }
        .padding(.top)
    }
}
