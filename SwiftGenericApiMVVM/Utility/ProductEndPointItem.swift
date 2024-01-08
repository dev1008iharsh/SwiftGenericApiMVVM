//
//  ProductEndPointItem.swift
//  SwiftApiMVVM
//
//  Created by My Mac Mini on 09/01/24.
//

import Foundation

enum ProductEndPointItem {
    case products // get product
    case addProduct(product : AddProduct) //add product - ama () ma je moklvu hoy eno model lakheloche
    //module -> case products - ava jetli screen etla bane jem ke comments
}

//https://fakestoreapi.com/products
extension ProductEndPointItem : EndPointType {
    
    var body: Encodable? {
        switch self{
        case .products :
            return nil
        case .addProduct (let product):
            return product
        }
    }
    
    var headers: [String : String]? {
        return ApiManager.commanHeaders
    }
     
    var path: String {
        switch self{
        case .products :
            return "products"
        case .addProduct :
            return "products/add"
        }
        //    case .comments :
        //        return "comments"
        //    }
    }
    
    
    var baseUrl: String {
        
        switch self{
        case .products :
            return "https://fakestoreapi.com/"
        case .addProduct :
            return "https://dummyjson.com/"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseUrl)\(path)")
    }
    
    var method: HttpMehtod {
        switch self{
        case .products :
            return .get
        case .addProduct:
            return .post
        }
        //    case .comments :
        //        return .get or .post
        //    }
    }
    
    
}
