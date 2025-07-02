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

extension DetailScreenModel {
    public static let testModel: DetailScreenModel = {
       DetailScreenModel(
        name: "Rick Sanchez",
        picture: .testModel,
        species: "Human",
        gender: "Male",
        type: "Genetic experiment",
        status: "unknown",
        cards: [
            DetailCardModel(type: .place, title: "Origin", body: "Earth (Replacement Dimension)", image: .origin),
            DetailCardModel(type: .place, title: "Location", body: "Citadel of Ricks", image: .location),
            DetailCardModel(type: .episode, title: "Episodes", body: "", image: .episode),
            DetailCardModel(type: .moreInfo, title: "More Info", body: "", image: .moreInfo)
        ]
       )
    }()
}
