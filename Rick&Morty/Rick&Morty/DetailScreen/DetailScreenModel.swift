//
//  DetailScreenModel.swift
//  Rick&Morty
//
//  Created by Juan Camilo Mendieta Hernández on 25/06/25.
//

import Foundation

struct DetailScreenModel {
    let id: Int
    let name: String
    let picture: CharacterImageModel
    let species: String
    let gender: String
    let type: String
    let status: String
    let cards: [DetailCardModel]
    
    init(
        id: Int = 1,
        name: String = "",
        picture: CharacterImageModel = CharacterImageModel(),
        species: String = "",
        gender: String = "",
        type: String = "",
        status: String = "",
        cards: [DetailCardModel] = []
    ) {
        self.id = id
        self.name = name
        self.picture = picture
        self.species = species
        self.gender = gender
        self.type = type
        self.status = status
        self.cards = cards
    }
}
