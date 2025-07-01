//
//  AppColors.swift
//  Rick&Morty
//
//  Created by Juan Camilo Mendieta Hernández on 18/06/25.
//

import SwiftUI

extension Color {
    public static let rickDarkGreen: Color = Color("DarkGreen")
    public static let rickYellow: Color = Color("Yellow")
    public static let rickLightGreen: Color = Color("LightGreen")
    public static let rickGreen: Color = Color("Green")
}

extension View {
    func setGreenGradientBackground() -> some View {
        self.background(
            LinearGradient(
                gradient:
                    Gradient(colors: [
                        Color.rickLightGreen,
                        Color.rickGreen,
                        Color.rickDarkGreen,
                        Color.rickGreen,
                        Color.rickLightGreen,
                    ]),
                startPoint: .bottomLeading,
                endPoint: .topTrailing)
        )
    }
}
