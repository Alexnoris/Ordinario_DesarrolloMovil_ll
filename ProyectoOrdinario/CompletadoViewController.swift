//
//  CompletadoViewController.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 07/06/22.
//

import UIKit
import Kingfisher

class CompletadoViewController: UIViewController {
    
    @Published var productoComprado: [Cart] = []

    @IBOutlet weak var tableProductosComprados: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        tableProductosComprados.register(UINib(nibName: "TableViewCellProductosComprados", bundle: nil), forCellReuseIdentifier: "cellProductosComprados")
        
        ConnectAPI.cmd.getProductosComprados(success: { producto in
            self.productoComprado = producto
        }, failure: {error in
            print(error.debugDescription)
        })
        
        DispatchQueue.main.async{
            self.tableProductosComprados.dataSource = self
            self.tableProductosComprados.delegate = self
        }
        
    }
    
    @IBAction func btnIrAProductos(_ sender: Any) {
        performSegue(withIdentifier: "vcvolveraproductos", sender: self)
    }
    

}

extension CompletadoViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productoComprado.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableProductosComprados.dequeueReusableCell(withIdentifier: "cellProductosComprados", for: indexPath) as? TableViewCellProductosComprados
        cell!.lblProductosComprados.text = productoComprado[indexPath.row].nombre
        cell!.lblPrecioProductosComprados.text = ("Precio: $\(productoComprado[indexPath.row].precio)")
        cell!.lblCantidadProductosComprados.text = String(productoComprado[indexPath.row].cantidad)
        cell!.imgProductosComprados.kf.setImage(with: URL(string: productoComprado[indexPath.row].imagen))
        
        
        return cell!
    }
    
    
}
