//
//  Post.swift
//  CombineExample
//
//  Created by Jun on 2022/02/25.
//

import Foundation
import Combine
import Alamofire

struct Post: Decodable {
    let userId:Int
    let postId:Int
    let title:String
    let body:String
    
    enum CodingKeys: String, CodingKey {
        case userId
        case postId = "id"
        case title
        case body
    }
}

struct PostPresenter: Identifiable {
    let id = UUID()
    let title:String
    
    init(model: Post) {
        self.title = model.title
    }
}

final class Example2ViewModel:ObservableObject {
    
    private let baseUrl:String = "https://jsonplaceholder.typicode.com/"
    private var task: Cancellable? = nil
    
    @Published var presenters:[PostPresenter] = []
    
    init() {
        self.fetchData()
    }
    
    private func fetchData() {
        
        self.task = AF.request(self.baseUrl + "posts", method: .get, parameters: nil)
            .publishDecodable(type: [Post].self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    ()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] response in
                switch response.result {
                case .success(let model):
                    self?.presenters = model.map { PostPresenter(model: $0) }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        
    }
    
    
}
