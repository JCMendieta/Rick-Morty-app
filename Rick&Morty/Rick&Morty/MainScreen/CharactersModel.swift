//
//  CharactersModel.swift
//  Rick&Morty
//
//  Created by Juan Camilo Mendieta Hernández on 17/06/25.
//

import Foundation

struct CharactersModel {
    let title: String
    var cards: [CharacterCardModel]
    
    init(title: String = "Characters",
         cards: [CharacterCardModel] = []
    ) {
        self.title = title
        self.cards = cards
    }
}

extension CharactersModel {
    public static var testModel: CharactersModel = {
       CharactersModel(
        title: "Characters",
        cards: [.testModel, .testModel, .testModel, .testModel, .testModel, .testModel, .testModel])
    }()
}
