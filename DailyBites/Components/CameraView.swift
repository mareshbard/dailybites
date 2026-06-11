import Foundation
import SwiftUI
import UIKit


struct CameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage? // ligação com o state da view pai
    @Environment(\.presentationMode) var presentationMode // fechar quando terminar
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController() // cria camera picker
        picker.delegate = context.coordinator
        picker.sourceType = .camera // diz a origem p/ camera
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // não precisa de updates
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraView
        init(_ parent: CameraView){
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image // passa a imagem selecionada para a view pai
            }
            parent.presentationMode.wrappedValue.dismiss() // fecha o picker
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
