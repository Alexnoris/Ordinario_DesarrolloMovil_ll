//
//  ServiciosViewController.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 01/06/22.
//

import UIKit

class ServiciosViewController: UIViewController {

    @IBOutlet weak var lblContenido: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblContenido.text = ""

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ConnectServicios(_ sender: Any) {
        ConnectAPI.cmd.getServicios(success: { servicios in
            DispatchQueue.main.async{
                self.lblContenido.text = servicios[0].nombre
            }
            
        }, failure: {error in
            print(error.debugDescription)
        })
        
    }
    
    
}
