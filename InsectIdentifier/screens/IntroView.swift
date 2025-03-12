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
        IntroModel(title: "Capture Insect", description: "Unveiling the fascinating world of insects by recognizing their unique features, habitats, and roles in nature.", image:"intro_1"),
        IntroModel(title: "Insect Identify", description: "Unveiling the fascinating world of insects by recognizing their unique features, habitats, and roles in nature.", image:"intro_2"),
        IntroModel(title: "AI assistance", description: "This feature uses advanced image recognition and machine learning to enhance insect study and awareness.", image:"intro_3")
    ]
    @State private var currentPage = 0
    
    @State private var moveOnHomePage: Bool = false
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<pages.count, id: \.self) { index in
                ZStack{
                    VStack{
                        Image(pages[index].image)
                            .resizable()
                            .scaledToFill()
                           
                            
                        
                        Spacer().frame(height: UIScreen.main.bounds.height * 0.15)
                    }
                    VStack{
                        Spacer()
                        VStack{
                            Text(pages[index].title).font(.title).fontWeight(.bold).padding(.bottom,5)
                            Text(pages[index].description).font(.system(size: 14))
                                .multilineTextAlignment(.center).padding(.horizontal,10).padding(.bottom,5)
                            
                            Button(action: {
                                if(currentPage<pages.count-1){
                                    currentPage = currentPage+1
                                }else{
                                    isFirstRun=false
                                    moveOnHomePage=true
                                }
                            }){
                                Text("Next")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical,10)
                                
                            }.frame(maxWidth: .infinity).foregroundColor(.white).background(Color.primaryColor).cornerRadius(100)
                                .padding(.horizontal,15)
                            
                            Button(action: {
                                isFirstRun=false
                                moveOnHomePage=true
                            }){
                                Text("Skip")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical,10)
                                
                            }.frame(maxWidth: .infinity).foregroundStyle(Color.primaryColor).cornerRadius(100)
                                .padding(.horizontal,15).padding(.bottom,5)
                            
                        }.frame(maxWidth: .infinity).background(.white)
                            .cornerRadius(20).shadow(radius:2).padding(.horizontal, 30)
                        Spacer().frame(height: UIScreen.main.bounds.height * 0.05)
                    }
                } .tag(index)
            }
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)).navigationBarBackButtonHidden().navigationDestination(isPresented:$moveOnHomePage) {
            HomeView()
        }
    }
}


#Preview {
    IntroView()
}
