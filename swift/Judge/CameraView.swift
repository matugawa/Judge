//
//  CameraView.swift
//  Judge
//
//  Created by s s on 2022/10/25.
//

import SwiftUI

struct CameraView:UIViewControllerRepresentable{
    @Binding var image:UIImage
    @Binding var showCamera:Bool
    @Binding var showResultView:Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller=UIImagePickerController()
        controller.sourceType = .camera
        controller.delegate=context.coordinator
        return controller
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator:NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        let parent:CameraView
        init(parent:CameraView){
            self.parent=parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image=info[.originalImage] as! UIImage
            self.parent.image=image
            self.parent.showCamera=false
            self.parent.showResultView=true
        }
    }
}
