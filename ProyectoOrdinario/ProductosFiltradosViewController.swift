//
//  ProductosFiltradosViewController.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 04/06/22.
//

import UIKit

class ProductosFiltradosViewController: UIViewController {
    
    @Published var productosFiltro: [Productos] = []
    
    @IBOutlet weak var tableProductosFiltrados: UITableView!
    
    var Filtro: String!
    
    var productoDetalle: String!
    
    @IBOutlet weak var imgCarrito2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapCarrito2 = UITapGestureRecognizer(target: self, action: #selector(tappedCarrito2))
        imgCarrito2.addGestureRecognizer(tapCarrito2)
        imgCarrito2.isUserInteractionEnabled = true
        
        tableProductosFiltrados.register(UINib(nibName: "TableViewCellProductosFiltro", bundle: nil), forCellReuseIdentifier: "cellProductosFiltro")

        ConnectAPI.cmd.getProductosFilter(categoria: Filtro!, success: {productoFiltro in
            self.productosFiltro = productoFiltro
        }, failure: { error in
            print(error.debugDescription)
        })
        
        DispatchQueue.main.async{
            self.tableProductosFiltrados.dataSource = self
            self.tableProductosFiltrados.delegate = self
        }
        
        
    }
    
    @objc func tappedCarrito2() {
        performSegue(withIdentifier: "vccarrito2", sender: self)
    }
    
}

extension ProductosFiltradosViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productosFiltro.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableProductosFiltrados.dequeueReusableCell(withIdentifier: "cellProductosFiltro", for: indexPath) as? TableViewCellProductosFiltro
        cell!.lblProductosFiltrados.text = productosFiltro[indexPath.row].nombre
        cell!.imgProductosFiltrados.kf.setImage(with: URL(string: productosFiltro[indexPath.row].imagen))
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productoDetalle = productosFiltro[indexPath.row].nombre
        performSegue(withIdentifier: "vcdetalleproductofiltro", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let product = segue.destination as? ProductoDetalleViewController {
            product.productoDetalle = productoDetalle!
        }
    }
    
    
}
