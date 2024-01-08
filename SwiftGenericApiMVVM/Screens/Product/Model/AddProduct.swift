//
//  AddProduct.swift
//  SwiftApiMVVM
//
//  Created by My Mac Mini on 09/01/24.
//

import Foundation
//Encode + Decodable ae banne no typealias Codeable che
struct AddProduct : Codable {
    var id : Int? = nil // aa karvathi aa param ma nahi nakhiye to pan chalse
    let title : String
}
