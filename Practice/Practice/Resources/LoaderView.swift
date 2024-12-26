//
//  LoaderView.swift
//  Practice
//
//  Created by Vishal Manhas on 26/12/24.
//

import SwiftUI

struct LoaderView: View {
    @Binding var isAnimating: Bool
    @State private var rotationAngle: Double = 0

    var body: some View {
        ZStack {
            Circle()
                .stroke(AngularGradient(gradient: Gradient(colors: [.red, .green]), center: .center), style: StrokeStyle(lineWidth: 2))
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(rotationAngle))
        }
        .onAppear {
            startRotation()
        }
    }

    private func startRotation() {
        withAnimation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false)) {
            rotationAngle = 360
        }
    }
}

#Preview {
    LoaderView(isAnimating: .constant(true))
}
