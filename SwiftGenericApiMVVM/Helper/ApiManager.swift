//
//  ApiManager.swift
//  SwiftApiMVVM
//
//  Created by My Mac Mini on 08/01/24.
//

import Foundation
import UIKit

enum DataError : Error {
    case invalidRepsonse
    case invalidURL
    case invalidData
    case network(Error?)
}

// nickname by us given to existing datatype
//typealias Handler = (Result<[Product], DataError>) -> Void
typealias Handler<T> = (Result<T, DataError>) -> Void

// singleton class - Aa class no ek single object j banse
class ApiManager{
    
    static let shared = ApiManager()
    private init(){}
    
    func request< T:Decodable >(modelType : T.Type, type : EndPointType, completion : @escaping Handler<T>) {
        //guard let url = URL(string: Constant.API.productURl) else { - ani jagya ae durect url enum manthi lese
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            //guard let data = data else { return } avu be var data lakhvani jarur nathi
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~=  response.statusCode else {
                completion(.failure(.invalidRepsonse))
                return
            }
            
            // Array      - [Product].self
            // Dictionary - Product.self
            //JSONDecoder() - Data ne model ma convert karse
            
            do{
                let model = try JSONDecoder().decode(modelType.self, from: data)
                completion(.success(model))
            }catch{
                completion(.failure(.network(error)))
            }
            
            
        }.resume()
    }
    
    
}


/*
func fetchProductList(completion: @escaping Handler){
    
    guard let url = URL(string: Constant.API.productURl) else {
        completion(.failure(.invalidURL))
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        //guard let data = data else { return }
        guard let data, error == nil else {
            completion(.failure(.invalidData))
            return
        }
        
        guard let response = response as? HTTPURLResponse,
              200 ... 299 ~=  response.statusCode else {
            completion(.failure(.invalidRepsonse))
            return
        }
        
        // Array      - [Product].self
        // Dictionary - Product.self
        //JSONDecoder() - Data ne model ma convert karse
        
        do{
            let products = try JSONDecoder().decode([Product].self, from: data)
            completion(.success(products))
        }catch{
            completion(.failure(.network(error)))
        }
        
        
    }.resume()
    
}
*/
