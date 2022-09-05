//
//  GenerateTableViewCell.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 03.09.2022.
//

import UIKit

class GenerateTableViewCell: UITableViewCell {


    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var qrTypeLabel: UILabel!
    @IBOutlet weak var qrInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(object: QRData){
        qrImageView.image = object.qrImg
        qrTypeLabel.text = object.qrType
        qrInfoLabel.text = object.qrInfo
    }
    
}
