//
//  LanguageScreenView.swift
//  InsectIdentifier
//
//  Created by Hussnain on 12/03/2025.
//

import SwiftUI

struct LanguageScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(AppConstants.LANG_CODE_KEY) private var langCode: String = "en"
    @AppStorage(AppConstants.FIRST_RUN_KEY) private var isFirstRun :Bool = true
    @State private var navigateToIntro = false
    private let languages = [
        LanguageModel(name: "English",code: "en"),
        LanguageModel(name: "Spanish",code: "es"),
        LanguageModel(name: "Portuguese",code: "pt"),
        LanguageModel(name: "Hindi",code: "hi"),
        LanguageModel(name: "Turkish",code: "tr"),
        LanguageModel(name: "French",code: "fr"),
        LanguageModel(name: "Indonesian",code: "in")
    ]
   
    var body: some View {
        VStack {
            TopBarView(title: "Change Languages",onBack: {
                if(!isFirstRun)
                {
                    presentationMode.wrappedValue.dismiss()
                }
                   
            }).padding()
            ScrollView {
                LazyVStack {
                    ForEach(languages) { item in
                        Button(action: {
                            langCode = item.code
                            
                            if isFirstRun {
                                navigateToIntro = true
                            } else {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            HStack {
                                Image("f_\(item.code)")
                                    .resizable()
                                    .frame(width: 31, height: 31)
                                
                                Text(item.name)
                                    .font(.body)
                                    .padding(.leading, 5)
                                
                                Spacer()
                                
                                if item.code == langCode {
                                    Image("lang_check")
                                        .foregroundColor(.accentColor)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .center))
                            .padding(.vertical, 18)
                            .padding(.horizontal, 15)
                            .background(Color.surfaceColor)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        }
                        .buttonStyle(PlainButtonStyle())
                       
                        .padding(.horizontal)
                        .padding(.vertical, 2).foregroundStyle(Color.onSurfaceColor)
                        
                    }
                }.padding(.top,10)
                
            }.frame(maxWidth: .infinity,maxHeight: .infinity)
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).navigationDestination(isPresented: $navigateToIntro) {
            IntroView()
        }.navigationBarBackButtonHidden()
        
        
    }
}

#Preview {
    LanguageScreenView()
}

