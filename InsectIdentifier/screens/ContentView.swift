//
//  ContentView.swift
//  InsectIdentifier
//
//  Created by Hussnain on 12/03/2025.
//

import SwiftUI

struct ContentView: View {
   
    var body: some View {
        NavigationStack {
            SplashView()
        }
    }
//    init(){
//        for familyName in UIFont.familyNames {
//            print(familyName)
//            for fontName in UIFont.fontNames(forFamilyName: familyName) {
//                print("-- \(fontName)")
//            }
//        }
//    }
}

#Preview {
    ContentView()
}
