//
//  ViewModelExample2.swift
//  CombineExample
//
//  Created by Jun on 2022/02/25.
//

import SwiftUI

struct ViewModelExample2: View {
    
    @ObservedObject var viewModel = Example2ViewModel()
    
    var body: some View {
        List(self.viewModel.presenters) {
            Text($0.title)
        }
    }
}

struct ViewModelExample2_Previews: PreviewProvider {
    static var previews: some View {
        ViewModelExample2()
    }
}
