import Foundation
@testable import Rick_Morty

final class ApiRequestMock: ApiUrlRequest {
    func searchCharacterBy(name: String) async throws -> CharacterSearchedEntity {
        let data = RickAndMortyJSONs.searchByName.data(using: .utf8) ?? Data()
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(CharacterSearchedEntity.self, from: data)
            return result
        } catch {
            throw error
        }
    }

    func characterRequest(id: Int) async throws -> CharacterEntity {
        let data = RickAndMortyJSONs.character.data(using: .utf8) ?? Data()
        let decoder = JSONDecoder()
        do {
            let character = try decoder.decode(CharacterEntity.self, from: data)
            return character
        } catch {
            throw error
        }
    }
}
