//
//  ApiService.swift
//  myListGitRepository
//
//  Created by Denis Mashkov on 04.09.2020.
//  Copyright © 2020 Denis Mashkov. All rights reserved.
//

import Foundation

class ApiService {
    private var dataTask: URLSessionTask?
    
    func getData(completion: @escaping (Result<[PublickRepositories], Error>) -> Void) {
        let url : String = "https://api.github.com/repositories?since=0"
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            do {
                let result = try JSONDecoder().decode([PublickRepositories].self, from: data)
                completion(.success(result))
            }
            catch{
                completion(.failure(error))
                print("failed to convert \(error.localizedDescription)")
            }
        })
        task.resume()
    }
}
