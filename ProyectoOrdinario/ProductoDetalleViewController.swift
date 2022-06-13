//
//  ProductoDetalleViewController.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 04/06/22.
//

import UIKit
import Kingfisher

class ProductoDetalleViewController: UIViewController {
    
    @Published var productDetail: [Productos] = []
    
    @Published var productoCarrito: [Cart] = []
    
    var productoDetalle: String!

    @IBOutlet weak var imgProductoDetalle: UIImageView!
    
    @IBOutlet weak var lblNombreProducto: UILabel!
    
    @IBOutlet weak var lblDescripcionProducto: UILabel!
    
    @IBOutlet weak var lblStock: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConnectAPI.cmd.getProductoDetalle(producto: productoDetalle!, success: {productosDetalle in
            self.productDetail = productosDetalle
            DispatchQueue.main.async{
                self.imgProductoDetalle.kf.setImage(with: URL(string: productosDetalle[0].imagen))
                self.lblNombreProducto.text = productosDetalle[0].nombre
                self.lblDescripcionProducto.text = productosDetalle[0].descripcion
                self.lblStock.text = ("Quedan:  \(productosDetalle[0].stock)")
            }
        }, failure: { error in
            print(error.debugDescription)
        })
        
    }

    @IBAction func btnAgregarProductoCarrito(_ sender: Any) {
        ConnectAPI.cmd.AddCarritoProducto(nombre: productDetail[0].nombre, precio: Int(productDetail[0].precio) ,cantidad: 1, imagen: productDetail[0].imagen, success: { carritoAgregar in
            self.productoCarrito = carritoAgregar
            
        }, failure: { error in
            print(error.debugDescription)
        })
        let alert = UIAlertController(title: "Producto agregado", message: "Se ha agregado su producto a su carrito", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
            UIAlertAction in
            self.navigationController?.popViewController(animated: true)
        })

        self.present(alert, animated: true, completion: nil)
    }
}
