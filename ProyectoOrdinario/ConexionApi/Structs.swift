//
//  Struct.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 01/06/22.
//

import Foundation
import SwiftUI

struct User: Codable{
//    let id: String
    let username: String
    let email: String
    let password: String
}

struct Productos: Codable {
    let id: String
    let nombre: String
    let descripcion: String
    let precio: Float
    let stock: Int
    let imagen: String
    let categorias_producto: Categorias_productos
    let encarrito: Bool
}

struct Categorias_productos: Codable{
    let nombre: String
    let imagen: String
}

struct Servicios: Codable{
    let nombre: String
}

struct Cart: Codable{
    let id: String
    let nombre: String
    let precio: Int
    let cantidad: Int
    let imagen: String
    let Comprado: Bool
}
