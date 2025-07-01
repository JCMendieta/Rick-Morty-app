//
//  CharacterImageModel.swift
//  Rick&Morty
//
//  Created by Juan Camilo Mendieta Hernández on 25/06/25.
//

import Foundation
import SwiftUI

struct CharacterImageModel {
    let imageUrl: URL?
    let backgroundColor: Color
    
    init(
        imageUrl: URL? = nil,
        backgroundColor: Color = .rickYellow
    ) {
        self.imageUrl = imageUrl
        self.backgroundColor = backgroundColor
    }
}

extension CharacterImageModel {
    static let testModel: CharacterImageModel = {
        CharacterImageModel(
            imageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        )
    }()
}
