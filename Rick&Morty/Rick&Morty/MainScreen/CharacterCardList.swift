import SwiftUI

struct CharacterCardList: View {
    let cards: [CharacterCardModel]
    let onCardTap: (CharacterCardModel) -> Void

    var body: some View {
        ForEach(cards) { card in
            CharacterCardView(model: card) {_ in 
                onCardTap(card)
            }
        }
    }
}
