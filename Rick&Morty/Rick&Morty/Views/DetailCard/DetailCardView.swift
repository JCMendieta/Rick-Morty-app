//
//  DetailCardView.swift
//  Rick&Morty
//
//  Created by Juan Camilo Mendieta Hernández on 25/06/25.
//

import SwiftUI

struct DetailCardView: View {
    private let model: DetailCardModel
    private let scheme: DetailCardViewScheme = .init()
    private let onCardSelected: (DetailCardModel) -> Void
    
    init(
        model: DetailCardModel,
        onCardSelected: @escaping (DetailCardModel) -> Void
    ) {
        self.model = model
        self.onCardSelected = onCardSelected
    }
    
    var body: some View {
        Button {
            onCardSelected(model)
        } label: {
            VStack(alignment: .leading, spacing: .none) {
                Text(model.title)
                    .styledTitleCard()
                    .padding()
                
                if !model.body.isEmpty {
                    Text(model.body)
                        .styledBodyCard()
                        .padding(.horizontal, scheme.bodyHorizontalPadding)
                }
                Image(model.image.rawValue)
                    .resizable()
                    .frame(width: scheme.imageWidth, height: scheme.imageWidth)
                    .padding()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.gray.opacity(scheme.opacity))
            .clipShape(RoundedRectangle(cornerRadius: scheme.cardRadius))
        }
    }
}

#Preview {
    DetailCardView(model: DetailCardModel.testModel) { _ in }
}
