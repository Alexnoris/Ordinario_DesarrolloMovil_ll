//
//  LoginViewController.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 20/05/22.
//

import UIKit
import SwiftUI

class LoginViewController: UIViewController {
    @Published var usuario: [User] = []
    
    var userLoged:String!
    

    @IBOutlet weak var inputUsuario: UITextField!
    
    @IBOutlet weak var inputPass: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
    
    @IBAction func btnLogin(_ sender: Any) {

        if (inputUsuario.text == "" || inputPass.text == ""){
                    let alert = UIAlertController(title: "Campos vacios", message: "Por favor rellena todos los campos", preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    self.present(alert, animated: true, completion: nil)
        }else{
            ConnectAPI.cmd.loginUsuario(user: self.inputUsuario.text!, password: self.inputPass.text!, success: { user in
                print(user)
            }, failure: { error in
                DispatchQueue.main.async{
                    print(error.debugDescription)
                }
            }, code: { codes in
                DispatchQueue.main.async{
                    if (codes >= 200 && codes <= 299){
                        let alert2 = UIAlertController(title: "Inicio de sesión correcto exitosamente!", message: "Será dirigido a la página de inicio", preferredStyle: UIAlertController.Style.alert)

                        alert2.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
                            UIAlertAction in
                            self.performSegue(withIdentifier: "vcinicio", sender: self)
                        })

                        self.present(alert2, animated: true, completion: nil)
                    
                    }
                    if (codes >= 400 && codes <= 499){
                        let alert3 = UIAlertController(title: "Datos no encontrados!", message: "Por favor registrese o recupere su cuenta", preferredStyle: UIAlertController.Style.alert)

                        alert3.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        self.present(alert3, animated: true, completion: nil)
                    }
                }
            })
            userLoged = inputUsuario.text!
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destino = segue.destination as? InicioViewController {
            destino.userLoged = userLoged
        }
    }
}

