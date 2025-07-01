//
//  DetailScreen.swift
//  Rick&Morty
//
//  Created by Juan Camilo Mendieta Hernández on 25/06/25.
//

import SwiftUI

struct DetailScreen: View {
    @StateObject var viewModel: DetailScreenViewModel = .init(fetchData: ApiRequest())
    private let scheme: DetailScreenScheme = .init()
    @State private var showMoreInfo = false
    @State private var selectedCard: DetailCardModel?
    @State private var typeOfCard: TypeOfCard?
    
    var showAddButton: Bool
    
    @Binding var saveCard: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ScrollView(showsIndicators: false) {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            characterName
                            characterImage
                            characterInfo
                            
                            if viewModel.shouldShowCards {
                                infoCards
                            }
                        }
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .top
                    )
                    .padding()
                    .setGreenGradientBackground()
                    
                    floatingButton
                }
                .task {
                    do {
                        try await viewModel.fetchDetailScreenData()
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    // MARK: Views
    var characterName: some View {
        Text(viewModel.data.name)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
    }
    
    var characterImage: some View {
        CharacterImageView(model: viewModel.data.picture)
    }
    
    var characterInfo: some View {
        VStack() {
            HStack{
                Text("\(viewModel.data.species) - \(viewModel.data.gender)")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            Text(viewModel.data.type)
                .font(.title3)
                .foregroundColor(.white)
            Text("Status: \(viewModel.data.status)")
                .font(.title3)
                .foregroundColor(.white)
        }
    }
    
    var infoCards: some View {
        VStack() {
            HStack(alignment: .top) {
                DetailCardView(model: viewModel.data.cards[0]) { card in
                    showMoreInfo = true
                    selectedCard = card
                }
                DetailCardView(model: viewModel.data.cards[1]) { card in
                    showMoreInfo = true
                    selectedCard = card
                }
            }
            HStack(alignment: .top) {
                DetailCardView(model: viewModel.data.cards[2]) { card in
                    showMoreInfo = true
                    selectedCard = card
                }
                DetailCardView(model: viewModel.data.cards[3]) { card in
                    if let wikiURL = viewModel.getWikiUrlFor(name: viewModel.data.name) {
                        UIApplication.shared.open(wikiURL)
                    }
                }
            }
        }
    }
    
    var floatingButton: some View {
        HStack(alignment: .bottom) {
            Spacer()
            Button {
                if showAddButton {saveCard.toggle()}
                dismiss()
            } label: {
                Image(systemName: showAddButton ? scheme.addButton : scheme.listButton)
                    .font(.title2)
                    .frame(width: scheme.buttonWidth, height: scheme.buttonWidth)
                    .background(Color.gray)
                    .clipShape(Circle())
            }
            
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.trailing, scheme.buttonPadding)
        .padding(.bottom, scheme.buttonPadding)
    }
}
