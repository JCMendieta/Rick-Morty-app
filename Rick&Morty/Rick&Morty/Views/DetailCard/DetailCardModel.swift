//
//  DetailCardModel.swift
//  Rick&Morty
//
//  Created by Juan Camilo Mendieta Hernández on 25/06/25.
//

import Foundation
import SwiftUI

struct DetailCardModel {
    let type: TypeOfCard
    let title: String
    let body: String
    let image: CardImage
    
    enum CardImage: String {
        case origin = "origint"
        case episode = "episodet"
        case location = "locationt"
        case moreInfo = "moret"
    }
}

enum TypeOfCard {
    case place, episode, moreInfo
}

extension DetailCardModel {
    public static let testModel: DetailCardModel = {
        DetailCardModel(
            type: .place,
            title: "Title",
            body: "rgergergjergjeigjroiejoirejgoierjgoirejg",
            image: .location
        )
    }()
}
