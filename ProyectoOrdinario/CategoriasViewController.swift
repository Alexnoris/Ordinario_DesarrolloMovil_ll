//
//  ComprarViewController.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 30/05/22.
//

import UIKit
import Kingfisher

class CategoriasViewController: UIViewController {
    
    @Published var categorias: [Categorias_productos] = []
    @Published var filtro: String!

    @IBOutlet weak var tablaCategorias: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablaCategorias.register(UINib(nibName: "TableViewCellCategorias", bundle: nil), forCellReuseIdentifier: "cellCategorias")
        
        ConnectAPI.cmd.getCategorias(success: {categorias_productos in
            self.categorias = categorias_productos
        }, failure: {error in
            print(error.debugDescription)
        })
        
        DispatchQueue.main.async{
            self.tablaCategorias.dataSource = self
            self.tablaCategorias.delegate = self
        }
        
    }
    
    
}


extension CategoriasViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categorias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaCategorias.dequeueReusableCell(withIdentifier: "cellCategorias", for: indexPath) as? TableViewCellCategorias
        cell!.lblCategoria.text = categorias[indexPath.row].nombre
        cell!.imgCategoria.kf.setImage(with: URL(string: categorias[indexPath.row].imagen))
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filtro = categorias[indexPath.row].nombre
        self.performSegue(withIdentifier: "vcproductosfiltrados", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let filtrado = segue.destination as? ProductosFiltradosViewController {
            filtrado.Filtro = filtro
        }
    }
    
}

