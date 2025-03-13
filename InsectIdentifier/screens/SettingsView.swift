//
//  HomeView.swift
//  InsectIdentifier
//
//  Created by Hussnain on 12/03/2025.
//

import SwiftUI


struct SettingsModel: Identifiable {
    let id: Int
    let title: String
    let icon: String
}

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    let buttons: [SettingsModel] = [
        SettingsModel(id: 1, title: "Introduction", icon: "ic_privacy"),
        SettingsModel(id: 2, title: "Privacy Policy", icon: "ic_privacy"),
        SettingsModel(id: 3, title: "Change Language", icon: "ic_languages"),
        SettingsModel(id: 4, title: "Premium Upgrade", icon: "ic_premium"),
        SettingsModel(id: 5, title: "Share App", icon: "ic_share")
    ]
    @State private var navigationId: Int? = nil
    @State private var isSharing = false
    var body: some View {
        VStack {
            TopBarView(title: "Settings", onBack: {
                presentationMode.wrappedValue.dismiss()
            }
            ).padding(.horizontal,15)
            
            ScrollView {
                LazyVStack {
                    ForEach(buttons) { button in
                        Button(action: {
                            if(button.id==5){
                                //Share App
                                isSharing=true
                            }else{
                                navigationId=button.id
                            }
                        }) {
                            HStack {
                                Image(button.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.blue)
                                Text(button.title)
                                    .font(.body)
                                    .padding(.leading, 10)
                               
                            }
                            .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .center))
                            .padding(.vertical, 18)
                            .padding(.horizontal, 15)
                            .background(Color.surfaceColor)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.vertical, 2).foregroundStyle(Color.onSurfaceColor)
                        
                    }
                }.padding(.top,10).padding(.horizontal,15)
                
            }
            
          
        }.navigationBarBackButtonHidden().navigationDestination(item:$navigationId) { destination in
            if(destination==1){
                IntroView()
            }else if(destination==2){
               
            }else if(destination==3){
                LanguageScreenView()
            }else if(destination==4){
                PremiumView()
            }
        }.sheet(isPresented: $isSharing) {
            ShareSheet(items: ["Check out this amazing app! Download it here: https://example.com"])
        }
       
    }
}
struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        uiViewController.excludedActivityTypes=[.saveToCameraRoll]
    }
}
#Preview {
    SettingsView()
}
