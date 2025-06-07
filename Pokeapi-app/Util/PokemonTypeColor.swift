//
//  PokemonTypeColor.swift
//  Pokeapi-app
//
//  Created by Breno Morais on 07/06/25.
//

import SwiftUI

enum PokemonTypeColor {
    static func color(for type: String) -> Color {
        switch type {
        case "fire": return Color.orange
        case "water": return Color.blue
        case "grass": return Color.green
        case "electric": return Color.yellow
        case "psychic": return Color.pink
        case "poison": return Color.purple
        case "bug": return Color.green.opacity(0.7)
        case "ground": return Color.brown
        case "rock": return Color.gray
        case "fighting": return Color.red
        case "fairy": return Color.pink.opacity(0.7)
        case "dragon": return Color.indigo
        case "ice": return Color.cyan
        case "ghost": return Color.indigo.opacity(0.7)
        case "normal": return Color.gray.opacity(0.5)
        case "dark": return Color.black
        case "steel": return Color.gray.opacity(0.8)
        case "flying": return Color.blue.opacity(0.5)
        default: return Color.gray
        }
    }
}
