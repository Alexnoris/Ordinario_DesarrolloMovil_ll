//
//  ViewController.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 19/05/22.
//

import UIKit
import SwiftUI


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func btnClickLogin(_ sender: Any) {
        performSegue(withIdentifier: "vclogin", sender: self)
    }
    
    @IBAction func btnClickRegister(_ sender: Any) {
        performSegue(withIdentifier: "vcregister", sender: self)
    }
        
    
}
