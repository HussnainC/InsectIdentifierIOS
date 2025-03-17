//
//  LanguageModel.swift
//  InsectIdentifier
//
//  Created by Hussnain on 12/03/2025.
//

import Foundation
import SwiftUICore
struct LanguageModel: Identifiable {
    let id = UUID()
    let name: LocalizedStringKey
    var code:String
}
