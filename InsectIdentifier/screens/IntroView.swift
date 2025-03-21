//
//  HomeView.swift
//  InsectIdentifier
//
//  Created by Hussnain on 12/03/2025.
//

import SwiftUI

struct IntroView: View {
    @AppStorage(AppConstants.FIRST_RUN_KEY) private var isFirstRun :Bool = true
    private let pages = [
        IntroModel(title: "introt1", description: "introd1", image:"intro_1"),
        IntroModel(title: "introt2", description: "introd2", image:"intro_2"),
        IntroModel(title: "introt3", description: "introd3", image:"intro_3")
    ]
    @State private var currentPage = 0
    
    @State private var moveOnHomePage: Bool = false
    @State private var moveOnPremiumPage: Bool = false
    var body: some View {
        ZStack{
            TabView(selection: $currentPage) {
                       ForEach(0..<pages.count, id: \.self) { index in
                           ZStack{
                               VStack{
                                   Image(pages[index].image)
                                                       .resizable()
                                                       .scaledToFill()
                                                       .frame(maxWidth: .infinity, maxHeight: .infinity)
                                   Spacer().frame(height: UIScreen.main.bounds.height * 0.15)
                               }
                           }.tag(index)
                        
                       }
                   }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            VStack{
                Spacer()
                VStack{
                    Text(pages[currentPage].title).font(.title).foregroundStyle(Color.onSurfaceColor).fontWeight(.bold).padding(.bottom,5)
                    Text(pages[currentPage].description).font(.system(size: 14)).foregroundStyle(Color.onSurfaceColor)
                        .multilineTextAlignment(.center).padding(.horizontal,10).padding(.bottom,5)
                    
                    Button(action: {
                        if(currentPage<pages.count-1){
                            currentPage = currentPage+1
                        }else{
                            isFirstRun=false
                            if(currentPage == pages.count - 1){
                                moveOnPremiumPage=true
                            }else{
                                moveOnHomePage=true
                            }
                          
                        }
                    }){
                        Text(currentPage == pages.count - 1 ? "pu" : "nt")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical,10)
                        
                    }.frame(maxWidth: .infinity).foregroundColor(.white).background(Color.primaryColor).cornerRadius(100)
                        .padding(.horizontal,15)
                    
                    Button(action: {
                        
                        isFirstRun=false
                        moveOnHomePage=true
                        
                    }){
                        Text(currentPage == pages.count - 1 ? "cwa" : "skp")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical,10)
                        
                    }.frame(maxWidth: .infinity).foregroundStyle(Color.primaryColor).cornerRadius(100)
                        .padding(.horizontal,15).padding(.bottom,5)
                    
                }.frame(maxWidth: .infinity).background(.white)
                    .cornerRadius(20).shadow(radius:2).padding(.horizontal, 30)
                Spacer().frame(height: UIScreen.main.bounds.height * 0.05)
            }
        }.navigationBarBackButtonHidden().navigationDestination(isPresented:$moveOnHomePage) {
            HomeView()
        }.navigationDestination(isPresented:$moveOnPremiumPage) {
            PremiumView()
        }
        
    }
}


#Preview {
    IntroView()
}
