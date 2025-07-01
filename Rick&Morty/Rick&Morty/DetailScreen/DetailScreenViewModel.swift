//
//  DetailScreenViewModel.swift
//  Rick&Morty
//
//  Created by Juan Camilo Mendieta Hernández on 25/06/25.
//

import Foundation

class DetailScreenViewModel: ObservableObject {
    @Published var data: DetailScreenModel
    @Published var isLoading: Bool
    let fetchData: ApiUrlRequest
    
    var shouldShowCards: Bool {
        data.cards.count == 4
    }
    
    init(
        data: DetailScreenModel = DetailScreenModel(),
        fetchData: ApiUrlRequest
    ) {
        self.data = data
        self.fetchData = fetchData
        self.isLoading = true
    }
    
    @MainActor
    func fetchDetailScreenData() async throws {
        do {
            data = try await getDetailScreenModel(from: fetchData.characterRequest(id: data.id))
            isLoading = false
        } catch {
            print("Error al obtener detalles: \(error)")
        }
    }
    
    func getWikiUrlFor(name: String) -> URL? {
        let formattedName = name.replacingOccurrences(of: " ", with: "_")
        
        guard let url = URL(string: "https://rickandmorty.fandom.com/en/wiki/\(formattedName)") else {
            return nil
        }
        
        return url
    }
    
    private func getDetailScreenModel(from character: CharacterEntity) -> DetailScreenModel {
        DetailScreenModel(
            name: character.name,
            picture: CharacterImageModel(imageUrl: URL(string: character.image)),
            species: character.species,
            gender: character.gender,
            type: character.type,
            status: character.status,
            cards: [
                DetailCardModel(type: .place, title: "Origin", body: character.origin.name, image: .origin),
                DetailCardModel(type: .place, title: "Location", body: character.location.name, image: .location),
                DetailCardModel(type: .episode, title: "Episodes", body: "", image: .episode),
                DetailCardModel(type: .moreInfo, title: "More Info", body: "", image: .moreInfo),
            ])
    }
}
