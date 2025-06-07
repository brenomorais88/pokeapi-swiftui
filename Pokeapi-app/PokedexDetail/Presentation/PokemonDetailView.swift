//
//  PokemonDetailView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 07/06/25.
//

import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject var viewModel: PokemonDetailViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                header
                types
                aboutSection
                description
                statsSection
            }
            .padding()
        }
        .background(viewModel.backgroundColor.ignoresSafeArea())
        .onAppear {
            Task {
                await viewModel.fetchDetails()
            }
        }
    }

    private var header: some View {
        VStack(spacing: 8) {
            HStack {
                Button(action: {
                    viewModel.goBack?()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.white)
                }

                Spacer()

                Text("#\(String(format: "%03d", viewModel.id))")
                    .foregroundColor(.white)
                    .bold()
            }

            HStack {
                Text(viewModel.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                Spacer()
            }

            if let imageURL = viewModel.imageURL {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 160, height: 160)
            }
        }
    }

    private var types: some View {
        HStack {
            ForEach(viewModel.types, id: \.self) { type in
                Text(type.capitalized)
                    .font(.caption)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.white.opacity(0.2))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
    }

    private var aboutSection: some View {
        VStack(spacing: 12) {
            Text("About")
                .font(.headline)
                .foregroundColor(.white)

            HStack {
                VStack {
                    Text(viewModel.weight)
                    Text("Weight")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack {
                    Text(viewModel.height)
                    Text("Height")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack {
                    Text(viewModel.moves.joined(separator: "\n"))
                    Text("Moves")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .foregroundColor(.white)
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
    }

    private var description: some View {
        Text(viewModel.description)
            .foregroundColor(.white)
            .font(.body)
            .multilineTextAlignment(.leading)
            .padding(.top)
    }

    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Base Stats")
                .font(.headline)
                .foregroundColor(.white)

            ForEach(viewModel.stats, id: \.label) { stat in
                HStack {
                    Text(stat.label)
                        .frame(width: 50, alignment: .leading)
                        .foregroundColor(.white)

                    Text(String(format: "%03d", stat.value))
                        .frame(width: 40, alignment: .leading)
                        .foregroundColor(.white)

                    ProgressView(value: Float(stat.value) / 100)
                        .tint(.white)
                }
            }
        }
        .padding(.top)
    }
}
