//
//  InicioViewController.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 20/05/22.
//

import UIKit

class InicioViewController: UIViewController {

    var userLoged:String!
    
    @IBOutlet weak var lblBievenida: UILabel!
    @IBOutlet weak var imgServicios: UIImageView!
    @IBOutlet weak var imgComprar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        lblBievenida.text = "Bienvenido \(userLoged!), que desea hacer: "

        let tapComprar = UITapGestureRecognizer(target: self, action: #selector(tappedComprar))
        imgComprar.addGestureRecognizer(tapComprar)
        imgComprar.isUserInteractionEnabled = true
        
        let tapServicios = UITapGestureRecognizer(target: self, action: #selector(tappedServicios))
        imgServicios.addGestureRecognizer(tapServicios)
        imgServicios.isUserInteractionEnabled = true
        
    }

    @objc func tappedComprar() {
        performSegue(withIdentifier: "vccomprar", sender: self)
    }
    
    @objc func tappedServicios() {
        performSegue(withIdentifier: "vcservicios", sender: self)
    }
}
