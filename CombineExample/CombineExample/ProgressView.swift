//
//  ProgressView.swift
//  CombineExample
//
//  Created by Jun on 2022/03/03.
//

//import SwiftUI
//
//struct ProgressView: View {
//
//    @State private var progress:Double = 0
//    private let total:Double = 1
//
//    @State private var dataTask:URLSessionDataTask?
//    @State private var observation: NSKeyValueObservation?
//    @State private var image:UIImage?
//
//    var body: some View {
//        VStack {
//            ZStack {
//                if image == nil {
//                    ProgressView("Downloading image...", value: progress, total: total)
//                        .progressViewStyle(LinearProgressViewStyle())
//                        .padding()
//                } else {
//                    Image(uiImage: image!)
//                        .resizable()
//                }
//            }
//
//            Spacer()
//
//            HStack {
//                Spacer()
//                Button {
//
//                } label: {
//                    Image(systemName: "arrow.clockwise")
//                }
//                .font(.largeTitle)
//
//            }
//        }
//    }
//}
//
//struct ProgressView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressView()
//    }
//}
