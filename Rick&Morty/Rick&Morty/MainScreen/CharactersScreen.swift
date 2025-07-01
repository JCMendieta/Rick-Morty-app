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
    @State private var showDetailScreenWithAddIcon = false
    @State var shouldSaveCard = false
    
    init(
        viewModel: CharactersViewModel = .init(fetchData: ApiRequest())
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                CharacterCardList(cards: viewModel.data.cards) { card in
                    viewModel.updateSelectedCharacter(with: card)
                    showDetailScreen = true
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .background(Color.rickDarkGreen)
            .navigationTitle(
                Text(viewModel.data.title)
            )
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search a character")) {
            ForEach(viewModel.searchedList) { character in
                Button {
                    viewModel.updateSelectedCharacter(with: character)
                    showDetailScreenWithAddIcon.toggle()
                } label: {
                    Text("\(character.name) - \(character.characterId)")
                }
            }
        }
        .fullScreenCover(isPresented: $showDetailScreen) {
            DetailScreen(
                viewModel: viewModel.getDetailCardViewModel(),
                showAddButton: false,
                saveCard: $shouldSaveCard
            )
        }
        .sheet(isPresented: $showDetailScreenWithAddIcon) {
            DetailScreen(
                viewModel: viewModel.getDetailCardViewModel(),
                showAddButton: true,
                saveCard: $shouldSaveCard
            )
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
        .onChange(of: shouldSaveCard) { _, newValue in
            viewModel.addCharacterToList()
        }
    }
}

#Preview {
    CharactersScreen(viewModel: .testModel)
}
