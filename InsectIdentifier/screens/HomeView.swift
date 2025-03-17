//
//  HomeView.swift
//  InsectIdentifier
//
//  Created by Hussnain on 12/03/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var destination: Int? = nil
    var body: some View {
        VStack {
            topBar
            content
        }
        .navigationBarHidden(true).navigationBarBackButtonHidden()
        .navigationDestination(item:$destination) { destination in
            if(destination==1){
                SettingsView()
            }else if(destination==2){
                CameraScreen()
            }else if(destination==3){
                GalleryScreen()
            }
        }
    }
    private var topBar: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("hello")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                
            }
            Spacer()
            Button(action: {
                destination=1
            }) {
                Image("img_menu")
                    .resizable()
                    .frame(width: 30, height: 20)
                    .foregroundColor(.black)
            }
        }
        .padding(.top, 5).padding(.horizontal, 15)
    }
    private var content: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("home_top")
                    .font(.body)
                
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                PremiumBoard(price: "Rs 3456.0", title: "Per Month")
                
                HomeButton(  title: NSLocalizedString("buttont_1", comment:""),
                             description: NSLocalizedString("button_des_1", comment:""),
                
                    iconName: "img_insect",
                    onClick: {
                        destination=2
                    }
                )
                
                HomeButton(
                    title: NSLocalizedString("gallery", comment:""),
                    description: NSLocalizedString("button_des_2", comment:""),
                    iconName: "img_gallery",
                    onClick: {
                        destination=3
                    }
                )
            }
            .padding(.top, 10).padding(.horizontal, 15)
        }
    }
    
    struct HomeButton: View {
        let title: String
        let description: String
        let iconName: String
        let onClick: () -> Void
        
        var body: some View {
            Button(action: onClick) {
                VStack(spacing: 5) {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55)
                        .padding(.top, 5)
                    
                    Text(title)
                        .foregroundStyle(Color.primaryColor)
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Text(description)
                    
                        .font(.footnote)
                        .foregroundColor(Color.grayColor)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(Color.surfaceColor)
                .cornerRadius(20)
                .shadow(radius: 4)
            }
        }
    }
}


#Preview {
    HomeView()
}
