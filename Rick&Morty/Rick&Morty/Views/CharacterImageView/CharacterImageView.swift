//
//  CharacterImageView.swift
//  Rick&Morty
//
//  Created by Juan Camilo Mendieta Hernández on 25/06/25.
//

import SwiftUI

struct CharacterImageView: View {
    private let model: CharacterImageModel
    private let scheme: CharacterImageScheme = .init()
    
    init(model: CharacterImageModel) {
        self.model = model
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: scheme.cornerRadius)
                .frame(
                    width: scheme.imageWidth,
                    height: scheme.imageWidth
                )
                .rotationEffect(Angle(degrees: scheme.rotationDegrees))
                .foregroundStyle(model.backgroundColor)
                .shadow(radius: scheme.shadowRadius)
            
            AsyncImage(url: model.imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                case .failure:
                    Image(systemName: scheme.failureIcon)
                        .font(.largeTitle)
                @unknown default:
                    ProgressView()
                }
            }
            .frame(
                width: scheme.imageWidth,
                height: scheme.imageWidth
            )
            .clipShape(RoundedRectangle(cornerRadius: scheme.cornerRadius))
            .rotationEffect(Angle(degrees: scheme.rotationImageDegrees))
            .shadow(radius: scheme.shadowRadius)
        }
        .frame(width: scheme.containerWidth, height: scheme.containerWidth)
    }
}

#Preview {
    CharacterImageView(model: .testModel)
}
