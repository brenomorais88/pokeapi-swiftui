//
//  PokemonDetailView.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 07/06/25.
//

import SwiftUI

import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject var viewModel: PokemonDetailViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color(viewModel.backgroundColor)
                    .ignoresSafeArea()

                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.hasError {
                    VStack(spacing: 12) {
                        Text(viewModel.errorMessage)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()

                        Button("Retry") {
                            Task {
                                await viewModel.fetchDetails()
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(8)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    PokemonDetailHeaderView(viewModel: viewModel, dismiss: dismiss)
                        .frame(width: geometry.size.width)
                        .zIndex(1)
                    ScrollView {
                        VStack(spacing: 16) {
                            PokemonDetailBodyContentView(viewModel: viewModel)
                        }
                        .padding()
                        .padding(.top, 48)
                    }
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
}

