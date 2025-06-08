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
            VStack(alignment: .center, spacing: 16) {
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
                    .offset(y: -190)
                }
            }
            .zIndex(1)
        }
    }

    private var types: some View {
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

    private var aboutSection: some View {
        VStack(spacing: 16) {
            Text(Strings.about)
                .font(.headline)
                .foregroundColor(Color(viewModel.backgroundColor))
                .bold()

            HStack(alignment: .bottom) {
                VStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Image("weight-icon")
                        Text(viewModel.weight)
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    Text(Strings.weight)
                        .font(.caption)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)

                Divider()
                    .frame(height: 40)

                VStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Image("height-icon")
                        Text(viewModel.height)
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    Text(Strings.height)
                        .font(.caption)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)

                Divider()
                    .frame(height: 40)

                VStack(spacing: 8) {
                    Text(viewModel.moves.joined(separator: "\n"))
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                    Text(Strings.moves)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .frame(height: 130)
    }

    private var description: some View {
        Text(viewModel.description)
            .foregroundColor(.black)
            .font(.system(size: 16))
            .multilineTextAlignment(.leading)
            .padding(.top)
    }

    private var statsSection: some View {
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

                    Divider()
                        .frame(height: 20)

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
