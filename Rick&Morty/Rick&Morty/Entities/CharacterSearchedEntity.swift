//
//  CharacterSearchedEntity.swift
//  Rick&Morty
//
//  Created by Juan Camilo Mendieta Hernández on 18/06/25.
//

import Foundation

struct CharacterSearchedEntity: Decodable {
    let info: InfoCharacterSearchedEntity
    let results: [CharacterEntity]
}

public struct InfoCharacterSearchedEntity: Codable {
    let count, pages: Int
    let next, prev: String?
}
