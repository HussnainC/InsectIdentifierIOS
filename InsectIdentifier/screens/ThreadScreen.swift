//
//  ThreadScreen.swift
//  InsectIdentifier
//
//  Created by Hussnain on 15/03/2025.
//

import SwiftUICore
import SwiftUI
import Photos


#Preview {
    ThreadScreen(fileItem:nil)
}
struct ThreadScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var textInput: String = ""
    @ObservedObject var viewModel: ThreadViewModel
    init(fileItem: FileItem?) {
        
        self.viewModel = ThreadViewModel(fileItem: fileItem)
    }

    var body: some View {
        VStack {
            TopBarView(title: "", onBack: {
                presentationMode.wrappedValue.dismiss()
            }
            ).padding(.horizontal,15)
            
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.conversation, id: \ .id) { item in
                            if item.isUser {
                                UserPromptView(item: item)
                            } else {
                                AIResponseView(item: item)
                            }
                        }
                    }
                    .padding()
                }
                
            }
            
            
            bottomBar
        }.navigationBarBackButtonHidden()
    }
    
    
    private var bottomBar: some View {
        HStack {
            TextField("Message", text: $textInput)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 50).fill(Color(.systemGray6)))
            
            Button(action: {
                if !textInput.isEmpty {
                    sendMessage()
                }
            }) {
                Image(systemName: "paperplane.fill")
                    .padding()
                    .background(Circle().fill(Color.blue))
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
    
    private func sendMessage() {
        guard !textInput.isEmpty else { return }
        
        viewModel.sendMessage(message: textInput)
        textInput = ""
    }
    
}
struct UserPromptView: View {
    var item: ThreadItem
    @State private var uiImage: UIImage?
    var body: some View {
        HStack {
            Spacer()
            if case .success(let successData) = item.threadState {
                VStack(alignment: .leading){
                    if successData.attachedUri != nil {
                        if let uiImage = uiImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame( maxHeight: 120)
                                .frame(maxWidth:200)
                                .clipped()
                           
                        } else {
                            ProgressView()
                                .frame(height: 150)
                        }
                       
                    }
                    Text(successData.prompt)
                        .padding(10)
                       
                } .clipShape(RoundedRectangle(cornerRadius: 20)).background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray5)))
                    .shadow(radius: 3).onAppear{
                        if successData.attachedUri != nil{
                            loadImage(path: successData.attachedUri!)
                        }
                    }
                
            }
        }
    }
    func loadImage(path:String) {
        let asset = PHAsset.fetchAssets(withLocalIdentifiers: [path], options: nil).firstObject
        let manager = PHImageManager.default()
        
        manager.requestImage(for: asset!,
                             targetSize: CGSize(width: 150, height: 150),
                             contentMode: .aspectFill,
                             options: nil) { image, _ in
            DispatchQueue.main.async {
                self.uiImage = image
            }
        }
    }
}

struct AIResponseView: View {
    var item: ThreadItem
    
    var body: some View {
        HStack(alignment:.top) {
            AIIndicator()
            
            let message: String = {
                switch item.threadState {
                case .success(let successData):
                    return successData.gemini?.candidates?
                        .compactMap { $0.content?.parts }
                        .flatMap { $0 }
                        .compactMap { $0.text }
                        .joined(separator: " ") ?? ""
                case .error:
                    return "Fail to get response"
                case .loading:
                    return "Loading..."
                }
            }()

          
            Text( message)
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue.opacity(0.2)))
            .shadow(radius: 3)
            Spacer()
        }
    }
}


struct ConversationIndicator: View {
    var text: String
    var contentColor: Color
    var containerColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .fill(containerColor)
                .frame(width: 30, height: 30)
            Text(String(text.prefix(2)))
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(contentColor)
        }
    }
}

struct UserIndicator: View {
    var body: some View {
        ConversationIndicator(text: "Me", contentColor: Color.gray, containerColor: Color.blue.opacity(0.5))
    }
}

struct AIIndicator: View {
    var body: some View {
        ConversationIndicator(text: "AI", contentColor: .white, containerColor: .blue)
    }
}

