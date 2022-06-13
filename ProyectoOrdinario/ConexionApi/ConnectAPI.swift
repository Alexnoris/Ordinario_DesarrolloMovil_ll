//
//  ConnectAPI.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 01/06/22.
//

import Foundation
import StrapiSwift

final class ConnectAPI{
    
    static let cmd = ConnectAPI()
    private let strapi = Strapi(scheme: .http, host: "localhost", port: 1337)
    
    func registrarUsuario(user: String, email: String, password: String, success: @escaping(_ user: [User]) -> (), failure: @escaping(_ error: Error?)-> (), code: @escaping(_ codes: Int)-> () ){
        strapi.register(
            username: user,
            email: email,
            password: password) { response in
                if let registrado = response.decodableValue(of: [User].self){
                    success(registrado)
                    code(response.statusCode)
                }else{
                    failure(response.error)
                    code(response.statusCode)
                }
        }
    }

    func loginUsuario(user: String, password: String, success: @escaping(_ user: [User]) -> (), failure: @escaping(_ error: Error?)-> (), code: @escaping(_ codes: Int)-> ()){
        strapi.login(
            identifier: user,
            password: password) { response in
                    
            if let loged = response.decodableValue(of: [User].self){
                success(loged)
                code(response.statusCode)
            }else{
                failure(response.error)
                code(response.statusCode)
            }
        }
    }
    
    func getProductos(success: @escaping(_ productos: [Productos]) -> (), failure: @escaping(_ error: Error?)-> ()) {
        let request = QueryRequest(contentType: "producto")

        strapi.exec(request: request) { response in
            if let producto = response.decodableValue(of: [Productos].self){
                success(producto)
            }else{
                failure(response.error)
            }
        }
        
    }
    
    func getProductosFilter(categoria: String ,success: @escaping(_ categorias_productos: [Productos]) -> (), failure: @escaping(_ error: Error?)-> ()){
        let request = StrapiRequest(
            method: .get,
            contentType: "productos",
            parameters: [
                "categorias_producto.nombre": categoria
            ]
        )

        strapi.exec(request: request) { response in
            if let productoFiltro = response.decodableValue(of: [Productos].self){
                success(productoFiltro)
            }else{
                failure(response.error)
            }
        }
    }
    
    func getProductoDetalle(producto: String ,success: @escaping(_ categorias_productos: [Productos]) -> (), failure: @escaping(_ error: Error?)-> ()){
        let request = StrapiRequest(
            method: .get,
            contentType: "productos",
            parameters: [
                "nombre": producto
            ]
        )

        strapi.exec(request: request) { response in
            if let productoDetalle = response.decodableValue(of: [Productos].self){
                success(productoDetalle)
            }else{
                failure(response.error)
            }
        }
    }
    
    func getCategorias(success: @escaping(_ categorias_productos: [Categorias_productos]) -> (), failure: @escaping(_ error: Error?)-> ()){
        let request = QueryRequest(contentType: "categorias-producto")

        strapi.exec(request: request) { response in
            if let categorias_producto = response.decodableValue(of: [Categorias_productos].self){
                success(categorias_producto)
            }else{
                failure(response.error)
            }
        }
    }
    
    func getServicios(success: @escaping(_ servicios: [Servicios]) -> (), failure: @escaping(_ error: Error?)-> ()){
        
        let request = StrapiRequest(
            method: .get,
            contentType: "servicios"
        )

        strapi.exec(request: request) { response in
            if let respuesta = response.decodableValue(of: [Servicios].self){
                success(respuesta)
            }else{
                failure(response.error)
            }
        }
            
    }
    
    func AddCarritoProducto(nombre: String, precio:Int ,cantidad: Int, imagen: String ,success: @escaping(_ carrito: [Cart]) -> (), failure: @escaping(_ error: Error?)-> ()){
        let request = CreateRequest(
            contentType: "Cart",
            parameters: [
                "nombre": nombre,
                "precio": precio,
                "cantidad": cantidad,
                "imagen": imagen
            ]
        )

        strapi.exec(request: request) { response in
            if let carritoAgregar = response.decodableValue(of: [Cart].self){
                success(carritoAgregar)
            }else{
                failure(response.error)
            }
        }
    }
    
    
    func getCarrito(success: @escaping(_ cart: [Cart]) -> (), failure: @escaping(_ error: Error?)-> ()){
        let request = StrapiRequest(
            method: .get,
            contentType: "carts",
            parameters: [
                "Comprado": false
            ]
        )

        strapi.exec(request: request) { response in
            if let carritoDatos = response.decodableValue(of: [Cart].self){
                success(carritoDatos)
            }else{
                failure(response.error)
            }
        }
    }
    
    func borrarProductoCarrito(id: String,success: @escaping(_ cart: [Cart]) -> (), failure: @escaping(_ error: Error?)-> ()){
        let request = DestroyRequest(
            contentType: "cart",
            id: id
        )

        strapi.exec(request: request) { response in
            if let carritoBorrar = response.decodableValue(of: [Cart].self){
                success(carritoBorrar)
            }else{
                failure(response.error)
            }
        }
            
    }
    
    func actualizarProductoComprado(id: String, success: @escaping(_ producto: [Cart]) -> (), failure: @escaping(_ error: Error?)-> ()){
        let request = UpdateRequest(contentType: "cart",
            id: id,
            parameters: [
                "Comprado": true
            ]
        )

        strapi.exec(request: request) { response in
            if let actualizarCart = response.decodableValue(of: [Cart].self){
                success(actualizarCart)
            }else{
                failure(response.error)
            }
        }
            
    }
    
    func getProductosComprados(success: @escaping(_ cart: [Cart]) -> (), failure: @escaping(_ error: Error?)-> ()){
        let request = StrapiRequest(
            method: .get,
            contentType: "carts",
            parameters: [
                "Comprado": true
            ]
        )

        strapi.exec(request: request) { response in
            if let carritoDatos = response.decodableValue(of: [Cart].self){
                success(carritoDatos)
            }else{
                failure(response.error)
            }
        }
    }
    
    func me(success: @escaping(_ user: [User]) -> (), failure: @escaping(_ error: Error?)-> ()){

        strapi.me{ response in
            if let user = response.decodableValue(of: [User].self){
                success(user)
            }else{
                failure(response.error)
            }
        }
            
    }
    
    
}
