//
//  ContentView.swift
//  Judge
//
//  Created by s s on 2022/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var selectedImage=UIImage()
    @State var showCamera=false
    @State var showImagePciker=false
    @State var showResultView=false
    
    var body: some View {
        VStack (spacing: 20){
            Button(action:{
                showImagePciker=true
            }){
                Text("PHOTO")
                    .bold()
                    .padding()
                    .frame(width: 120, height: 50)
                    .foregroundColor(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.cyan, lineWidth: 3)
                    )
            }
            Button(action:{
                showCamera=true
            }){
                Text("CAMERA")
                    .bold()
                    .padding()
                    .frame(width: 120, height: 50)
                    .foregroundColor(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.cyan, lineWidth: 3)
                    )
            }
        }
        .sheet(isPresented: $showImagePciker, content: {
            ImagePicker(selectedImage: self.$selectedImage, showResultView: $showResultView)
        })
        .sheet(isPresented:
            $showCamera, content: {
            CameraView(image:$selectedImage,
            showCamera: $showCamera, showResultView: $showResultView)
        })
        .fullScreenCover(isPresented: $showResultView, content: {
            ResultView(
                image:$selectedImage,
                showResultView:$showResultView)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
