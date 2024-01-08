//
//  EndPointType.swift
//  SwiftApiMVVM
//
//  Created by My Mac Mini on 08/01/24.
//

import Foundation

enum HttpMehtod : String{
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path : String { get }
    var baseUrl : String { get }
    var url : URL? { get }
    var method : HttpMehtod { get }
}

enum EndPointItems {
    case products
    //module -> case products - ava jetli screen etla bane jem ke comments
}

//https://fakestoreapi.com/products
extension EndPointItems : EndPointType {
   
    var path: String {
        switch self{
        case .products :
            return "products"
        }
        //    case .comments :
        //        return "comments"
        //    }
    }
    
    
    var baseUrl: String {
        return "https://fakestoreapi.com/"
    }
    
    var url: URL? {
        return URL(string: "\(baseUrl)\(path)")
    }
    
    var method: HttpMehtod {
        switch self{
        case .products :
            return .get
        }
        //    case .comments :
        //        return .get or .post
        //    }
    }
    
    
}
