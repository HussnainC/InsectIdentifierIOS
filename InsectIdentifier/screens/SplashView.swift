//
//  ContentView.swift
//  InsectIdentifier
//
//  Created by Hussnain on 11/03/2025.
//

import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    @AppStorage(AppConstants.FIRST_RUN_KEY) private var isFirstRun :Bool = true

    var body: some View {
        ZStack {
            ZStack{
                Image("splashBg")
                    .resizable()
                    .scaledToFill()
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black.opacity(1.0),
                        Color.black.opacity(0.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            }.ignoresSafeArea()
            VStack{
                   Text("ai_insect")
                    .font(.custom(Fonts.NunitoBlack, size: 40)).foregroundStyle(Color.primaryColor)
                Text("identifier")
                    .font(.custom(Fonts.NunitoBlack, size: 30)).foregroundStyle(Color.white)
                Image("butterFlies")
                    .resizable()
                    .frame(width: 266, height: 271)
                    .padding(.vertical, 10)
                Text("sp_des").foregroundStyle(Color.surfaceColor).multilineTextAlignment(.center).padding(.horizontal,20)
                
                Button(action: {
                    isActive = true
                }) {
                    Text("start")
                        .font(.custom(Fonts.NunitoRegular, size: 18))
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .frame(maxWidth: .infinity) 
                .background(Color.primaryColor)
                .foregroundStyle(Color.white)
                .cornerRadius(100)
                .padding(.horizontal, 20)
                .padding(.top, 30)
   
            }
        }.navigationDestination(isPresented:$isActive) {
            if(isFirstRun){
                LanguageScreenView()
            }else{
                HomeView()
            }
        }
    }
}
#Preview {
    SplashView()
}
