//
//  DetailScreenViewModelTests.swift
//  Rick&MortyTests
//
//  Created by Juan Camilo Mendieta Hernández on 2/07/25.
//

@testable import Rick_Morty
import XCTest

final class DetailScreenViewModelTests: XCTestCase {
    var fetchData: ApiRequestMock!
    var sut: DetailScreenViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        fetchData = ApiRequestMock()
        sut = DetailScreenViewModel(data: DetailScreenModel.testModel, fetchData: fetchData)
    }

    override func tearDownWithError() throws {
        fetchData = nil
        sut = nil
        try super.tearDownWithError()
    }

    func test_fetchDetailScreenData() async throws {
        // Given
        XCTAssertTrue(sut.isLoading, "isLoading debe ser true antes de cargar los datos")
        // When
        try await sut.fetchDetailScreenData()
        try await Task.sleep(nanoseconds: 100_000_000)
        // Then
        XCTAssertFalse(sut.isLoading, "isLoading debe ser false después de cargar los datos")
        XCTAssertEqual(sut.data.name, "Rick Sanchez")
        XCTAssertEqual(sut.data.species, "Human")
        XCTAssertEqual(sut.data.gender, "Male")
    }

    func test_getWikiUrlFor() {
        // Given
        let name = "Rick Sanchez"
        let expectedUrl = URL(string: "https://rickandmorty.fandom.com/en/wiki/Rick_Sanchez")
        // When
        let url = sut.getWikiUrlFor(name: name)
        // Then
        XCTAssertEqual(url, expectedUrl, "La URL generada debe ser la esperada para el nombre con espacios")
    }


}
