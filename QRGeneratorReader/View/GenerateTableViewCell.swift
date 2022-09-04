//
//  GenerateTableViewCell.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 03.09.2022.
//

import UIKit

class GenerateTableViewCell: UITableViewCell {

    @IBOutlet weak var emogi: UILabel!
    @IBOutlet weak var emogiName: UILabel!
    @IBOutlet weak var emogiDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(object: Emogi){
        self.emogi.text = object.emogi
        self.emogiDescription.text = object.descriptions
        self.emogiName.text = object.name
    }
    
}
