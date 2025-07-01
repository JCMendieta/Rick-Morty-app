//
//  CharactersViewModel.swift
//  Rick&Morty
//
//  Created by Juan Camilo Mendieta Hernández on 17/06/25.
//

import Foundation

class CharactersViewModel: ObservableObject {
    @Published var data: CharactersModel
    @Published var searchedList: [CharacterCardModel]
    @Published var selectedCharacter: CharacterCardModel
    let fetchData: ApiUrlRequest
    
    init(
        data: CharactersModel = .init(),
        fetchData: ApiUrlRequest
    ) {
        self.data = data
        self.searchedList = []
        self.selectedCharacter = .init()
        self.fetchData = fetchData
    }
    
    func clearSearchedList() {
        searchedList = []
    }
    
    @MainActor
    func fetchCharacterBy(name: String) async throws {
            searchedList = try await getSearchedCharacterCardModel(
                from: fetchData.searchCharacterBy(name: name)
            )
    }
    
    private func getSearchedCharacterCardModel(from search: CharacterSearchedEntity) -> [CharacterCardModel] {
        search.results.map { character in
            CharacterCardModel(
                characterId: character.id,
                name: character.name,
                species: character.species,
                gender: character.gender,
                imageUrl: URL(string: character.image)
            )
        }
    }
    
    func updateSelectedCharacter(with character: CharacterCardModel) {
        selectedCharacter = character
    }
    
    func getDetailCardViewModel() -> DetailScreenViewModel {
        DetailScreenViewModel(data: DetailScreenModel(id: selectedCharacter.characterId), fetchData: ApiRequest())
    }
    
    func addCharacterToList() {
        data.cards.append(selectedCharacter)
    }
}

extension CharactersViewModel {
    public static var testModel: CharactersViewModel = {
        CharactersViewModel(data: .testModel, fetchData: ApiRequest())
    }()
}
