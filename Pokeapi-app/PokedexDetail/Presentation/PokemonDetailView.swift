//
//  PokemonDetailView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 07/06/25.
//

import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject var viewModel: PokemonDetailViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color(viewModel.backgroundColor)
                    .ignoresSafeArea()
                headerContent
                    .frame(width: geometry.size.width)
                    .zIndex(1)
                ScrollView {
                    VStack(spacing: 16) {
                        bodyContent
                    }
                    .padding()
                    .padding(.top, 48)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchDetails()
            }
        }
        .navigationBarHidden(true)
    }

    private var headerContent: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
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

    private var bodyContent: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 16) {
                types
                aboutSection
                description
                statsSection
            }
            .padding(24)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .ignoresSafeArea(edges: .bottom)
            )
            .padding(.top, 190)
            .zIndex(0)

            VStack(spacing: 8) {
                Image("pokeball-background")
                    .resizable()
                    .frame(width: 208, height: 208)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .offset(y: -40)

                if let imageURL = viewModel.imageURL {
                    AsyncImage(url: imageURL) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 200, height: 200)
                    .offset(y: -180)
                }
            }
            .zIndex(1)
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
