//
//  TableViewCellProductosFiltro.swift
//  ProyectoOrdinario
//
//  Created by Alejandro Noris on 04/06/22.
//

import UIKit

class TableViewCellProductosFiltro: UITableViewCell {

    @IBOutlet weak var lblProductosFiltrados: UILabel!
    @IBOutlet weak var imgProductosFiltrados: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
