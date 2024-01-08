//
//  ProductViewModel.swift
//  SwiftApiMVVM
//
//  Created by My Mac Mini on 08/01/24.
//

import Foundation


final class ProductViewModel{
    
    var products : [Product] = []
    
    var eventHandler : ((_ event : Event) -> Void)?
    
    func fetchProduct(){
         
        eventHandler?(.loading)
        //ApiManager.shared.request(modeltype: [Comment].self, type: EndPointItems.comment)
        ApiManager.shared.request(modelType: [Product].self, type: ProductEndPointItem.products) { [ weak self ] response in
            
            guard let self else { return }
            
            eventHandler?(.stopLoading)
             
            switch response{
            case .success(let productsFromApi):
                
                self.products = productsFromApi
                eventHandler?(.dataLoaded)
                
            case .failure(let error):
                
                print(error)
                eventHandler?(.network(error))
                
            }
        }
    }
    
    func addProduct(parameters : AddProduct){
        ApiManager.shared.request(modelType: AddProduct.self, type: ProductEndPointItem.addProduct(product: parameters)) { result in
           
            switch result{
            case .success(let product):
                self.eventHandler?(.newProductAdded(product: product))
            case .failure(let error):
                self.eventHandler?(.network(error))
             
            }
        }
    }
    /*
    func fetchProducts(){
        
        eventHandler?(.loading)
        
        ApiManager.shared.fetchProductList { [ weak self ] response in
            
            guard let self else { return }
            eventHandler?(.stopLoading)
            
            switch response{
            case .success(let productsFromApi):
                
                self.products = productsFromApi
                eventHandler?(.dataLoaded)
                
            case .failure(let error):
                
                print(error)
                eventHandler?(.network(error))
                
            }
        }
    }*/
}

extension ProductViewModel{
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case network(Error?)
        case newProductAdded(product : AddProduct)
    }

}
