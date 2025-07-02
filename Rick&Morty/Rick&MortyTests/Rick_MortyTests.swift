//
//  Rick_MortyTests.swift
//  Rick&MortyTests
//
//  Created by Juan Camilo Mendieta Hernández on 2/07/25.
//

@testable import Rick_Morty
import XCTest

final class CharactersViewModelTests: XCTestCase {
    var fetchData: ApiRequestMock!
    var sut: CharactersViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        fetchData = ApiRequestMock()
        sut = CharactersViewModel(data: CharactersModel.testModel, fetchData: fetchData)
    }

    override func tearDownWithError() throws {
        fetchData = nil
        sut = nil
        try super.tearDownWithError()
    }

    func test_fetchCharacterBy_whenSearchAName_setsSearchedList() async throws {
        // Given
        let nameToSearch = "Rick"
        sut.searchedList = []
        // When
        try await sut.fetchCharacterBy(name: nameToSearch)
        try await Task.sleep(nanoseconds: 100_000_000)
        // Then
        XCTAssertFalse(sut.searchedList.isEmpty, "searchedList debería contener resultados después de buscar un nombre")
        XCTAssertEqual(sut.searchedList.first?.name, "Rick Sanchez", "El primer resultado debería ser 'Rick Sanchez'")
    }

    func test_clearSearchedList_whenANameWasSearched() async throws {
        // Given
        let nameToSearch = "Rick"
        try await sut.fetchCharacterBy(name: nameToSearch)
        try await Task.sleep(nanoseconds: 100_000_000)
        XCTAssertFalse(sut.searchedList.isEmpty, "Precondición: searchedList debe tener resultados antes de limpiar")
        // When
        sut.clearSearchedList()
        // Then
        XCTAssertTrue(sut.searchedList.isEmpty, "searchedList debe estar vacío después de llamar a clearSearchedList")
    }

    func test_updateSelectedCharacter() {
        // Given
        let testCharacter = CharacterCardModel(
            id: UUID(),
            characterId: 2,
            name: "Morty Smith",
            species: "Human",
            gender: "Male"
        )
        // When
        sut.updateSelectedCharacter(with: testCharacter)
        // Then
        XCTAssertEqual(sut.selectedCharacter, testCharacter, "selectedCharacter debe actualizarse correctamente con el personaje dado")
    }

    func test_addCharacterToList() {
        // Given
        let testCharacter = CharacterCardModel(
            id: UUID(),
            characterId: 3,
            name: "Summer Smith",
            species: "Human",
            gender: "Female"
        )
        // When
        sut.selectedCharacter = testCharacter
        sut.addCharacterToList()
        // Then
        XCTAssertTrue(sut.data.cards.contains(testCharacter), "data.cards debe contener el personaje agregado")
    }

}
