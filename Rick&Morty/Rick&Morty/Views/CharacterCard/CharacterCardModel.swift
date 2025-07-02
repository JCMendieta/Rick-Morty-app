//
//  CharacterCardModel.swift
//  Rick&Morty
//
//  Created by Juan Camilo Mendieta Hernández on 17/06/25.
//

import Foundation

struct CharacterCardModel: Identifiable, Equatable {
    let id: UUID
    let characterId: Int
    let name: String
    let species: String
    let gender: String
    let imageUrl: URL?
    
    init(
        id: UUID = .init(),
        characterId: Int = 1,
        name: String = "",
        species: String = "",
        gender: String = "",
        imageUrl: URL? = nil
    ) {
        self.id = id
        self.characterId = characterId
        self.name = name
        self.species = species
        self.gender = gender
        self.imageUrl = imageUrl
    }
}

extension CharacterCardModel {
    public static let testModel: CharacterCardModel = {
        CharacterCardModel(
            name: "Rick Testing",
            species: "Human Testing",
            gender: "Male Testing",
            imageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        )
    }()
}
