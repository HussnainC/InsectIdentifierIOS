//
//  HomeView.swift
//  InsectIdentifier
//
//  Created by Hussnain on 12/03/2025.
//

import SwiftUI


struct CameraScreen: View {
    @Environment(\.presentationMode) var presentationMode
   
  
    var body: some View {
        VStack {
            TopBarView(title: "Camera", onBack: {
                presentationMode.wrappedValue.dismiss()
            }
            ).padding(.horizontal,15)
            Spacer()
            
        }.navigationBarBackButtonHidden()
       
    }
}

#Preview {
    CameraScreen()
}
