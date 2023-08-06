//
//  MovieService.swift
//  Final Work
//
//  Created by Lucas Robaert on 05/08/23.
//

import Foundation


enum MovieServiceError: Error {
    case couldNotReturnList
}

class MovieService {
    
    func fetchMoviesList(page: Int = 1, completion: @escaping(Result<[MovieDetail], MovieServiceError>) -> Void) {
        
        let urlApi = "https://api.themoviedb.org/4/list/1?page=\(page)"
        
        guard let url = URL(string: urlApi) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZmYxNWY3ODFhOWU1NDM1Y2Y3YjA2NjBkNTkyZTk5OCIsInN1YiI6IjVmMjYyYTA2ZTE5NGIwMDAzNTkwZTRjZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Bx4h8vnnOLLj9FIDFi5ySu8FvAZf638zgwB6g8CBfqQ", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request){data, urlResponse, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.couldNotReturnList))
                return
            }
            
            if let httpResponse = urlResponse as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            
            do{
                print(data)
                let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                
                completion(.success(response.results))
                           
              } catch  {
                  print(error)
                    completion(.failure(.couldNotReturnList))
              }
        }
        
        task.resume()
    }
}
