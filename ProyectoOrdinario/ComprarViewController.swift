//
//  CategoriasViewController.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 04/06/22.
//

import UIKit
import Kingfisher

class ComprarViewController: UIViewController {
    
    @Published var products: [Productos] = []
    
    var productoDetalle: String!
    
    @IBOutlet weak var imgCarrito: UIImageView!
    
    @IBOutlet weak var tablaProductos: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapCarrito = UITapGestureRecognizer(target: self, action: #selector(tappedCarrito))
        imgCarrito.addGestureRecognizer(tapCarrito)
        imgCarrito.isUserInteractionEnabled = true
        
        tablaProductos.register(UINib(nibName: "TableViewCellProductos", bundle: nil), forCellReuseIdentifier: "cellProductos")

        ConnectAPI.cmd.getProductos(success: {productos in
            self.products = productos
        }, failure: { error in
            print(error.debugDescription)
        })
        
        
        DispatchQueue.main.async{
            self.tablaProductos.dataSource = self
            self.tablaProductos.delegate = self
        }
        
    }
    
    @IBAction func btnCategorias(_ sender: Any) {
        performSegue(withIdentifier: "vccategorias", sender: self)
    }
    
    @objc func tappedCarrito() {
        performSegue(withIdentifier: "vccarrito", sender: self)
    }
    

}

extension ComprarViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaProductos.dequeueReusableCell(withIdentifier: "cellProductos", for: indexPath) as? TableViewCellProductos
        cell!.lblProducto.text = products[indexPath.row].nombre
        cell!.imgProducto.kf.setImage(with: URL(string: products[indexPath.row].imagen))
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productoDetalle = products[indexPath.row].nombre
        performSegue(withIdentifier: "vcdetalleproducto", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let product = segue.destination as? ProductoDetalleViewController {
            product.productoDetalle = productoDetalle!
        }
    }
}
