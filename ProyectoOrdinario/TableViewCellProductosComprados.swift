//
//  TableViewCellProductosComprados.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 12/06/22.
//

import UIKit

class TableViewCellProductosComprados: UITableViewCell {

    @IBOutlet weak var imgProductosComprados: UIImageView!
    
    @IBOutlet weak var lblProductosComprados: UILabel!
    
    @IBOutlet weak var lblPrecioProductosComprados: UILabel!
    
    @IBOutlet weak var lblCantidadProductosComprados: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
