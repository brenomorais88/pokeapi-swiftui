# Pokédex SwiftUI

A modern Pokédex for iOS built with SwiftUI, displaying the first 151 Pokémon with official images. The app consumes data from the [PokeAPI](https://pokeapi.co/) and shows sprites from the official repository. Features include search, infinite scrolling, error/empty states, and clean architecture patterns.

<p align="center">
  <img src="docs/demo.gif" alt="Pokédex SwiftUI Demo" width="400"/>
</p>

---

## Features

- List of the first 151 Pokémon with official images
- Dynamic search by name, number, or partial match
- Infinite scroll: loads 15 Pokémon at a time, more on scroll
- Pokémon detail view (types, height, weight, description, stats)
- Loading, error, and empty states
- Navigation with Coordinator Pattern
- MVVM + Clean Architecture
- Async/await for networking and state management
- Unit tests included

---

## Tech Stack

- **SwiftUI**
- **Async/Await**
- **MVVM + Clean Architecture**
- **XCTest**

---

## Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/brenomorais88/pokeapi-swiftui.git
   cd pokeapi-swiftui
   ```

2. **Open in Xcode**
   - Requires Xcode 14 or later.
   - Open `Pokeapi-app.xcodeproj`.

3. **Build & Run**
   - Select an iOS Simulator and press `Cmd+R`.

---

## APIs Used

- **Pokémon List:** [https://pokeapi.co/api/v2/pokemon](https://pokeapi.co/api/v2/pokemon)
- **Sprites:**  
  `https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/{pokemon-id}.png`

---


## Testing

Run all tests via Xcode (`Cmd+U`).

- Unit tests for UseCases, Repositories, and ViewModels

---


## License

MIT

---

## Credits

- [PokeAPI](https://pokeapi.co/)
- [Sprites](https://github.com/PokeAPI/sprites)
