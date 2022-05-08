//
//  NetworkManager.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 25.04.2022.
//

import Foundation
import Alamofire

enum Results<T> {
    case success(T)
    case failure(Error)
}

final class NetworkManager {
    
    internal static let shared: NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()
    
    private let reachabilityManager = NetworkReachabilityManager()?.isReachable
    
    internal func isConnectedToInternet() -> Bool {
        return reachabilityManager ?? false
    }
    
    internal func request<T: Codable>(_ request: URLRequestConvertible,
                             decodeToType type: T.Type,
                             completionHandler: @escaping (Swift.Result<T,Error>) -> ()) {
        AF.request(request).responseData { response in

            switch response.result {

            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(type.self, from: data)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
        }
    }
    
}

