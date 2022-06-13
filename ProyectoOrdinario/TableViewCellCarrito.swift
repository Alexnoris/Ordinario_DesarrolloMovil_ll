//
//  TableViewCellCarrito.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 07/06/22.
//

import UIKit

//protocol TableViewCellCarritoDelegate: AnyObject {
//    func didTapButton()
//}

class TableViewCellCarrito: UITableViewCell {
    
//    weak var delegate: TableViewCellCarritoDelegate?
    
    var buttonPressed : (() -> ()) = {}
    
    var stepperPressed : (() -> ()) = {}

    @IBOutlet weak var imgProductoCarrito: UIImageView!
    
    @IBOutlet weak var lblProductoCarrito: UILabel!
    
    @IBOutlet weak var lblCantidadCarrito: UILabel!
    
    @IBOutlet weak var stepperCarrito: UIStepper!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var lblProductoPrecio: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnAcion(_ sender: Any) {
        buttonPressed()
    }
    
    @IBAction func stepperAction(_ sender: Any) {
        stepperPressed()
    }
    
}
