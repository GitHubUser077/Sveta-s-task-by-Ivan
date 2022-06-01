//
//  NetworkManager.swift
//  VKApp
//
//  Created by mac on 30.05.2022.
//

import Foundation


class NetworkManager {
    
    
    static let shared = NetworkManager()
    

    
    private init() {}
    
  
    
    
        //MARK: - Private
    
 
    
    private enum APIError: Error {
        case invalidURL
        case noDataReturned
    }
    
   
    
    func request<T: Codable>(url: URL?, expecting: T.Type , completion: @escaping (Result<T, Error>) -> Void ) {
        guard let url = url else {
            completion(.failure(APIError.invalidURL))
          return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }
            
            do {
                let result = try JSONDecoder() .decode(expecting, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
