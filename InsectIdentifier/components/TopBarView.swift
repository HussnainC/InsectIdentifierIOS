//
//  TopBarView.swift
//  InsectIdentifier
//
//  Created by Hussnain on 12/03/2025.
//

import SwiftUICore
import SwiftUI


struct TopBarView: View {
    var title: String
    var onBack: (() -> Void)?

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 20, weight: .semibold))
            Spacer()
            Button(action: {
                onBack?()
            }) {
                Image(systemName: "arrow.left")
                    
                    .font(.title2)
                    .foregroundColor(Color.onBackgroundColor)
                    .padding(6)
                    .background(Color.backgroundColor)
                    .clipShape(Circle())
                    .shadow(radius: 1)
                    
            }
        }
    }
}

#Preview {
    TopBarView(title: "Change Languages")
}

