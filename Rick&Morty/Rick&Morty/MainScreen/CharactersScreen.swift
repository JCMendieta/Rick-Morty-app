//
//  ContentView.swift
//  Rick&Morty
//
//  Created by Juan Camilo Mendieta Hernández on 17/06/25.
//

import SwiftUI

struct CharactersScreen: View {
    @StateObject var viewModel: CharactersViewModel
    @State var searchText = ""
    @State private var showDetailScreen = false
    
    init(
        viewModel: CharactersViewModel = .init(fetchData: ApiRequest())
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.data.cards) { card in
                    CharacterCardView(model: card) { card in
                        viewModel.updateSelectedCharacter(with: card)
                        showDetailScreen = true
                    }
                    .fullScreenCover(isPresented: $showDetailScreen) {
                        EmptyView()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .background(Color.rickDarkGreen)
            .navigationTitle(
                Text(viewModel.data.title)
            )
            .toolbarBackground(.blue, for: .navigationBar)
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search a character")) {
            ForEach(viewModel.searchedList) { character in
                Button {
                    viewModel.updateSelectedCharacter(with: character)
                } label: {
                    Text("\(character.name) - \(character.characterId)")
                }
            }
        }
        .onChange(of: searchText) { _, newValue in
            Task {
                if (!newValue.isEmpty && newValue.count >= 3) {
                    do {
                        try await viewModel.fetchCharacterBy(name: newValue)
                    }
                } else {
                    viewModel.clearSearchedList()
                }
            }
        }
        .environment(\.colorScheme, .dark)
    }
}

//#Preview {
//    CharactersScreen()
//}
