//
//  TableViewCellProductos.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 04/06/22.
//

import UIKit

class TableViewCellProductos: UITableViewCell {

    @IBOutlet weak var imgProducto: UIImageView!
    @IBOutlet weak var lblProducto: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
