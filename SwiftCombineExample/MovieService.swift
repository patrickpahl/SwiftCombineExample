//
//  MovieService.swift
//  SwiftCombineExample
//
//  Created by Patrick Pahl on 3/14/21.
//

import Foundation

enum ServiceError: Error {
    case serviceError(error: Error)
    case other
}

class MovieService {
    
    static let shared = MovieService()
    private let apiKey = "k_zagcoi66"
    private let baseURL = "https://imdb-api.com/en/API/"
    
    //https://imdb-api.com/en/API/Top250Movies
    func fetchTop250Movies(completion: @escaping (Swift.Result<[Movie], ServiceError>) -> Void) {
        
        let urlString = baseURL + "Top250Movies/" + apiKey
        guard let url = URL(string: urlString) else {
            completion(.failure(ServiceError.other))
            return
        }
        
        let task =  URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(ServiceError.serviceError(error: error!)))
                return
            }
            
            var response: TopMoviesResponse?
            
            do {
                response = try JSONDecoder().decode(TopMoviesResponse.self, from: data)
            } catch {
                completion(.failure(ServiceError.other))
                print("Failed to decode data")
            }
            
            guard let movies = response?.items else {
                print("response error")
                completion(.failure(ServiceError.other))
                return
            }
            
            completion(.success(movies))
            
        }
        task.resume()
    }
    
    func searchMovies(searchText: String, completion: @escaping (Swift.Result<[MovieSearch], ServiceError>) -> Void) {
        //https://imdb-api.com/en/API/Search/k_zagcoi66/Inception 2010
        let urlString = baseURL + "Search/" + apiKey + "/" + searchText
        guard let url = URL(string: urlString) else {
            completion(.failure(ServiceError.other))
            return
        }
        
        print("urlString = \(urlString)")
        
        let task =  URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(ServiceError.serviceError(error: error!)))
                return
            }
            
            var response: MovieSearchResponse?
            
            do {
                response = try JSONDecoder().decode(MovieSearchResponse.self, from: data)
            } catch {
                completion(.failure(ServiceError.other))
                print("Failed to decode data")
            }
            
            guard let movies = response?.results else {
                print("response error")
                completion(.failure(ServiceError.other))
                return
            }
            
            completion(.success(movies))
            
        }
        task.resume()
    }
    
}
