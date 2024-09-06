
/*
import Foundation
import SwiftUI


struct ImagePickerForProfile: UIViewControllerRepresentable{
     
    @Environment (\.presentationMode) private var presentationMode
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var selectedImage: UIImage
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerForProfile>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
         return imagePicker
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject,  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
        var parent: ImagePickerForProfile
        
        init (_ parent: ImagePickerForProfile){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[ UIImagePickerController.InfoKey.originalImage] as? UIImage   {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
    
}

*/
