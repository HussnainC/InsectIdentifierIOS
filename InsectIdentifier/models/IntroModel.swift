//
//  IntroModel.swift
//  InsectIdentifier
//
//  Created by Hussnain on 12/03/2025.
//

import Foundation
import SwiftUICore
struct IntroModel: Identifiable {
    let id = UUID()
    let title: LocalizedStringKey
    let description: LocalizedStringKey
    let image: String
}
