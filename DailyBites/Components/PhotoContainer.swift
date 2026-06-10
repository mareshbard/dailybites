//
//  PhotoContainer.swift
//  DailyBites
//
//  Created by Yohane Cavalcante on 09/06/26.
//

import SwiftUI
import AVFoundation
import PhotosUI

struct PhotoContainer: View {
    
    @Binding var imageData: Data?  // igual aos outros campos do form
    
    @State private var showCamera: Bool = false
    @State private var cameraPermissionDenied: Bool = false
    @State private var showPhotoOptions = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingCamera = false
    @State private var showingPhotosPicker = false
    
    // Propriedade auxiliar para exibir a imagem
    private var image: UIImage? {
        guard let data = imageData else { return nil }
        return UIImage(data: data)
    }
    
    var body: some View {
        VStack {
            
            Button {
                checkCameraPermission()
                showPhotoOptions = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemBackground))
                        .frame(maxWidth: .infinity, minHeight: 200)
                    
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, minHeight: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        Image(systemName: "photo.badge.plus")
                            .font(Font.title.bold())
                            .foregroundColor(.secondary)
                    }
                }
            }
            .buttonStyle(.plain)
            .alert("", isPresented: $showPhotoOptions) {
                Button {
                    if showCamera { showingCamera = true }
                } label: {
                    Label("Tire uma foto", systemImage: "camera")
                }
                
                Button {
                    showingPhotosPicker = true
                } label: {
                    Label("Selecione uma foto", systemImage: "photo.on.rectangle")
                }
                Button("Cancelar", role: .cancel) {}
            }
            .sheet(isPresented: $showingCamera) {
                CameraView(image: Binding(
                    get: { image },
                    set: { newImage in
                        imageData = newImage?.jpegData(compressionQuality: 0.8)
                    }
                ))
                .ignoresSafeArea()
            }
            .photosPicker(
                isPresented: $showingPhotosPicker,
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()
            )
            .onChange(of: selectedItem) { _, newItem in
                if let newItem = newItem {
                    Task {
                        if let data = try? await newItem.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            imageData = image.jpegData(compressionQuality: 0.8)
                        }
                    }
                }
            }
            .alert("Acesso à câmera negado", isPresented: $cameraPermissionDenied) {
                Button("Abrir Configurações") {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
                Button("Cancelar", role: .cancel) {}
            } message: {
                Text("Permita o acesso à câmera nas configurações do dispositivo.")
            }
        }
    }
    
    func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            showCamera = true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        showCamera = true
                    } else {
                        cameraPermissionDenied = true
                    }
                }
            }
        case .denied, .restricted:
            cameraPermissionDenied = true
        @unknown default:
            break
        }
    }
}

//#Preview {
//    PhotoContainer()
//}
