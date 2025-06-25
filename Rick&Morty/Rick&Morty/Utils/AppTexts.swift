//
//  AppTexts.swift
//  Rick&Morty
//
//  Created by Juan Camilo Mendieta Hernández on 18/06/25.
//

import SwiftUI

extension Text {
    func styledTitleCharacterCard() -> some View {
        self
            .foregroundColor(.white)
            .textCase(.uppercase)
            .multilineTextAlignment(.leading)
            .font(.headline)
    }
    
    func styledBodyCharacterCard() -> some View {
        self
            .foregroundColor(.white)
            .font(.body)
    }
}
