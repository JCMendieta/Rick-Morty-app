//
//  CharacterCardView.swift
//  Rick&Morty
//
//  Created by Juan Camilo Mendieta Hernández on 17/06/25.
//

import SwiftUI

struct CharacterCardView: View {
    let model: CharacterCardModel
    let scheme: CharacterCardScheme = .init()
    let onCardSelected: (CharacterCardModel) -> Void
    
    init(
        model: CharacterCardModel = .init(),
        onCardSelected: @escaping (CharacterCardModel) -> Void
    ) {
        self.model = model
        self.onCardSelected = onCardSelected
    }
    
    var body: some View {
        HStack {
            Button {
                onCardSelected(model)
            } label: {
                VStack(alignment: .leading) {
                    Text(model.name)
                        .styledTitleCharacterCard()
                        .padding()
                    Text("\(model.species) - \(model.gender)")
                        .styledBodyCharacterCard()
                        .padding()
                }
                Spacer()
                AsyncImage(url: model.imageUrl) { phase in
                    switch phase {
                    case .failure:
                        Image(systemName: scheme.failureImage)
                            .font(.largeTitle)
                    case .empty:
                        EmptyView()
                    case .success(let image):
                        image
                            .resizable()
                    default:
                        ProgressView()
                    }
                }
                .frame(
                    width: scheme.imageWidth,
                    height: scheme.imageWidth
                )
                .clipShape(RoundedRectangle(cornerRadius: scheme.imageCornerRadius))
                .shadow(radius: scheme.shadowRadius)
                .padding(scheme.imagePadding)
            }
        }
        .background(.gray.opacity(scheme.opacity))
        .clipShape(RoundedRectangle(cornerRadius: scheme.cardRadius))
    }
}

struct CharacterCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 18) {
            CharacterCardView(model: .testModel) { _ in
                
            }
            CharacterCardView(model: .testModel) { _ in
                
            }
            CharacterCardView(model: .testModel) { _ in
                
            }
        }
        .background(.black)
    }
}
