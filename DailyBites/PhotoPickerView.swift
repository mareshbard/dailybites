//
//  PhotoPickerView.swift
//  DailyBites
//
//  Created by user on 28/04/26.
//

import SwiftUI
import PhotosUI


struct PhotoPickerView: View {
    
    @Binding var imageData: Data?
    @State private var newImage: PhotosPickerItem?
    @State private var movieImage: UIImage?
    
    var body: some View {
        PhotosPicker(selection: $newImage){
            Group {
                if let imageData, let uiImage = UIImage(data: imageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                    
                } else{
                    Image(systemName: "photo.badge.plus.fill")
                        .font(.largeTitle)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .background(Color.backgroundImageDefault)
                        .tint(Color.black)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .onChange(of: newImage){
            guard let newImage else {return}
            
            Task {
                imageData = try await
                newImage.loadTransferable(type: Data.self)
            }
        }
    }
}

#Preview {
    PhotoPickerView(imageData: .constant(nil))
}
