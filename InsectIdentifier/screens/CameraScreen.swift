//
//  HomeView.swift
//  InsectIdentifier
//
//  Created by Hussnain on 12/03/2025.
//

import SwiftUI
import AVFoundation


struct CameraScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var cameraModel = CameraViewModel()
    @State private var isCameraAllowed: Bool = false
    var latestImagePath: String? = nil
    var body: some View {
        ZStack {
            if(isCameraAllowed){
                CameraPreview(cameraModel: cameraModel)
                    .ignoresSafeArea()
            }
           
            
            VStack {
                TopBarView(title: "capture_img") {
                    presentationMode.wrappedValue.dismiss()
                }.padding(.horizontal,15)
                Spacer()
                
                HStack {
                    Button(action: {
                       
                    }) {
                        Image(uiImage: latestImagePath != nil ? UIImage(contentsOfFile: latestImagePath!) ?? UIImage(contentsOfFile: "ic_gallery")! : UIImage(systemName: "photo")!)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                    }
                    
                    Spacer()
                    
                    Button(action: {
//                        cameraModel.capturePhoto { path in
//                            if let path = path {
//                                onImageCapture(path)
//                            }
//                        }
                    }) {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 60, height: 60)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        cameraModel.toggleFlash()
                    }) {
                        Image(systemName: cameraModel.isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.5))
                    .clipShape(Circle())
                }
                .padding(.bottom, 30)
                .padding(.top).padding(.horizontal)
                .background(Color.black.opacity(0.6))
                
            }
        }
        .onAppear{
            checkCameraPermission { granted in
                isCameraAllowed=granted
                if granted {
                    
                    print("Camera access granted!")
                    cameraModel.setupCamera()
                    // Start camera session
                } else {
                    print("Camera access denied. Show an alert to the user.")
                }
            }
        }
        .onDisappear {
            cameraModel.stopSession()
        }.navigationBarBackButtonHidden()
    }
    
    private  func checkCameraPermission(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            // Permission already granted
            completion(true)
        case .notDetermined:
            // Request permission
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        case .denied, .restricted:
            // Permission denied or restricted
            completion(false)
        @unknown default:
            completion(false)
        }
    }
}
struct CameraPreview: UIViewControllerRepresentable {
    var cameraModel: CameraViewModel
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        let previewLayer = AVCaptureVideoPreviewLayer(session: cameraModel.session)
        previewLayer.videoGravity = .resizeAspect
        previewLayer.frame = UIScreen.main.bounds
        controller.view.layer.addSublayer(previewLayer)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

#Preview {
    CameraScreen()
}
