//
//  ViewModelExample.swift
//  CombineExample
//
//  Created by Jun on 2022/02/25.
//

import SwiftUI
import Foundation
import Combine

final class ExampleViewModel:ObservableObject {
    
    @Published var counter:Int = 0
    
    func startCounter() {
        
    }
    
    private func increaseCounter() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeSelector), userInfo: nil, repeats: true)
    }
    
    @objc private func timeSelector() {
        self.counter += 1
    }
    
    
}



struct ViewModelExample: View {
    
    @ObservedObject var viewModel = ExampleViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            Button("Start Counter") {
                self.viewModel.startCounter()
            }
            Text("\(self.viewModel.counter)")
        }
    }
}

struct ViewModelExample_Previews: PreviewProvider {
    static var previews: some View {
        ViewModelExample()
    }
}
