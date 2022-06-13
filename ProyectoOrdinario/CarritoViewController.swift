//
//  CarritoViewController.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 07/06/22.
//

import UIKit
import SwiftUI

class CarritoViewController: UIViewController {
    
    @Published var carrito: [Cart] = []
    
    @Published var carritoBorrar: [Cart] = []
    
    @Published var carritoActualizado: [Cart] = []

    @IBOutlet weak var tableCarrito: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableCarrito.register(UINib(nibName: "TableViewCellCarrito", bundle: nil), forCellReuseIdentifier: "cellCarrito")
        
        ConnectAPI.cmd.getCarrito(success: {carritoDatos in
            self.carrito = carritoDatos
        }, failure: {error in
            print(error.debugDescription)
        })
        
        DispatchQueue.main.async{
            self.tableCarrito.dataSource = self
            self.tableCarrito.delegate = self
        }
        
        
    }
    
    @IBAction func btnCompletarCompra(_ sender: Any) {
        if self.carrito.count == 0{
            let alert3 = UIAlertController(title: "Carrito vacío", message: "Por favor agregue algún producto a su carrito", preferredStyle: UIAlertController.Style.alert)

            alert3.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            self.present(alert3, animated: true, completion: nil)
        }else{
            carrito.forEach{product in
                ConnectAPI.cmd.actualizarProductoComprado(id: product.id, success: {carritoActualizar
                    in
                    print(carritoActualizar)
                    self.carritoActualizado = carritoActualizar
                    }, failure: {error in
                        print(error.debugDescription)
                    })
            }
            let alert = UIAlertController(title: "Producto Comprado!", message: "Gracias por su compra", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
                UIAlertAction in
                self.performSegue(withIdentifier: "vcfinalizado", sender: self)
            })

            self.present(alert, animated: true, completion: nil)
        }

    }
}
    


extension CarritoViewController:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carrito.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCarrito.dequeueReusableCell(withIdentifier: "cellCarrito", for: indexPath) as? TableViewCellCarrito
        cell!.lblProductoCarrito.text = carrito[indexPath.row].nombre
        cell!.imgProductoCarrito.kf.setImage(with: URL(string: carrito[indexPath.row].imagen))
        cell!.lblProductoPrecio.text = String("Precio: $\(carrito[indexPath.row].precio)")
        cell!.lblStatus.text = String(carrito[indexPath.row].Comprado)
        cell!.lblCantidadCarrito.text = String(1)
        cell!.stepperCarrito.minimumValue = 1
        cell!.stepperCarrito.maximumValue = 9
        
        cell!.stepperPressed = {
            cell!.lblCantidadCarrito.text = String(cell!.stepperCarrito.value)
            cell!.lblProductoPrecio.text = String("Precio: $\(self.carrito[indexPath.row].precio * Int(cell!.stepperCarrito.value))")
        }
        
        cell!.buttonPressed = {
            ConnectAPI.cmd.borrarProductoCarrito(id: self.carrito[indexPath.row].id, success: {carritoBorrar in
                self.carritoBorrar = carritoBorrar
            }, failure: {error in
                print(error.debugDescription)
            })
            let alert2 = UIAlertController(title: "Producto Borrado!", message: "Su producto \(self.carrito[indexPath.row].nombre) lo ha borrado del carrito", preferredStyle: UIAlertController.Style.alert)

            alert2.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            self.present(alert2, animated: true, completion: nil)
            
            self.carrito.remove(at: indexPath.row)
            self.tableCarrito.deleteRows(at: [indexPath], with: .automatic)
        }

        return cell!
    }
    
}
    

