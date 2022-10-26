//
//  ImagePicker.swift
//  Judge
//
//  Created by s s on 2022/10/24.
//

import SwiftUI
import PhotosUI

struct ImagePicker:UIViewControllerRepresentable{
    @Binding var selectedImage:UIImage
    @Binding var showResultView:Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var conf=PHPickerConfiguration()
        conf.filter = .images
        let picker=PHPickerViewController(configuration: conf)
        picker.delegate=context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    //Class photo libraryから画像を取得する
    class Coordinator: NSObject, PHPickerViewControllerDelegate{
        let parent: ImagePicker
        init(parent: ImagePicker){
            self.parent=parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            //photo libraryで選択後閉じる
            picker.dismiss(animated: true)
            for image in results{
                image.itemProvider.loadObject(ofClass: UIImage.self, completionHandler:{
                    (image, error) in
                    if let image=image as? UIImage{
                        self.parent.selectedImage=image
                        self.parent.showResultView=true
                    }
                })
            }
        }
    }
}
