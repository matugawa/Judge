//
//  ResultView.swift
//  Judge
//
//  Created by s s on 2022/10/24.
//

import SwiftUI
import CoreML
import Vision

struct ResultView: View {
    @Binding var image:UIImage
    @Binding var showResultView:Bool
    @State var classificationLabel=""
    
    func createClassificationRequest()->VNCoreMLRequest{
        do{
            let conf=MLModelConfiguration()
            let model=try VNCoreMLModel(for: Resnet50(configuration: conf).model)
            let request=VNCoreMLRequest(model: model, completionHandler: {
                request, error in
                //画像分類処理
                doClassification(request: request)
            })
            return request
        }catch{
            fatalError("cant read model")
        }
    }
    
    func doClassification(request: VNRequest){
        guard let results=request.results else{
            return
        }
        let classification=results as! [VNClassificationObservation]
        classificationLabel=classification[0].identifier
    }
    
    func classifyImage(image:UIImage){
        guard let ciImage=CIImage(image: image)else{
            fatalError("couldnt convert to CIImage")
        }
        let handler=VNImageRequestHandler(ciImage: ciImage)
        let classificationRequest=createClassificationRequest()
        do{
            try handler.perform([classificationRequest])
        }catch{
            fatalError("fail to classification")
        }
    }
    
    var body: some View {
        VStack(spacing: 30){
            Image(uiImage:self.image)
                .resizable()
                .frame(width: 300,
                       height:300)
            Text("\(classificationLabel)")
            Button(action:{
                showResultView=false
            }){
                Text("RETURN")
            }
        }
        .onAppear{
            classifyImage(image:self.image)
        }
    }
}


