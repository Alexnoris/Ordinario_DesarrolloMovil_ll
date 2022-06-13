//
//  RegisterViewController.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 20/05/22.
//

import UIKit
import SwiftUI

class RegisterViewController: UIViewController {
    

    @IBOutlet weak var inputUsuarioR: UITextField!
    @IBOutlet weak var inputCorreoR: UITextField!
    @IBOutlet weak var inputPasswordR: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func btnRegistrarse(_ sender: Any) {
        if (inputUsuarioR.text == "" || inputPasswordR.text == "" || inputUsuarioR.text == ""){
            let alert = UIAlertController(title: "Campos vacios", message: "Por favor rellena todos los campos", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            self.present(alert, animated: true, completion: nil)
        }
        else{
            ConnectAPI.cmd.registrarUsuario(user: self.inputUsuarioR.text!, email: self.inputCorreoR.text!, password: self.inputPasswordR.text!, success: {user in
                DispatchQueue.main.async{
                    print(user)
                    
                }
            }, failure: { error in
                DispatchQueue.main.async{
                    print(error.debugDescription)
                }
            }, code: { codes in
                DispatchQueue.main.async{
                    if (codes >= 200 && codes <= 299){
                        let alert2 = UIAlertController(title: "Se ha registrado exitosamente!", message: "Por favor vaya a iniciar sesión", preferredStyle: UIAlertController.Style.alert)

                        alert2.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
                            UIAlertAction in
                            self.performSegue(withIdentifier: "vclogin2", sender: self)
                        })

                        self.present(alert2, animated: true, completion: nil)
                    
                    }
                    if (codes >= 400 && codes <= 499){
                        let alert3 = UIAlertController(title: "Datos ya registrados!", message: "Por favor eliga otro nombre de usuario o correo", preferredStyle: UIAlertController.Style.alert)

                        alert3.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        self.present(alert3, animated: true, completion: nil)
                    }
                }
            })
        }

            
    }
}
    

