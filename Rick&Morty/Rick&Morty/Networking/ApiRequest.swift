//
//  ApiRequest.swift
//  Rick&Morty
//
//  Created by Juan Camilo Mendieta Hernández on 18/06/25.
//

import Foundation

enum ApiError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

protocol ApiUrlRequest {
    func searchCharacterBy(name: String) async throws -> CharacterSearchedEntity
}

struct ApiRequest {
    private func encodeSpaceInText(_ text: String) -> String {
        let textWithOnlyOneSpace = text.trimmingCharacters(in: .whitespaces)
        return textWithOnlyOneSpace.replacingOccurrences(of: " ", with: "%20")
    }
}

extension ApiRequest: ApiUrlRequest {
    func searchCharacterBy(name: String) async throws -> CharacterSearchedEntity {
        let endpoint = "https://rickandmortyapi.com/api/character/?name=\(encodeSpaceInText(name))"
        
        guard let url = URL(string: endpoint) else {
            throw ApiError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(CharacterSearchedEntity.self, from: data)
        } catch {
            throw ApiError.invalidData
        }
    }
}
