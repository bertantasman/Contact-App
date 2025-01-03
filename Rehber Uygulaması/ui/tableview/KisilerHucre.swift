//
//  KisilerHucre.swift
//  Rehber Uygulaması
//
//  Created by Bertan Taşman on 4.12.2024.
//

import UIKit

class KisilerHucre: UITableViewCell {

    @IBOutlet weak var imageGender: UIImageView!
    @IBOutlet weak var labekKisiNumara: UILabel!
    @IBOutlet weak var labelKisiSoyad: UILabel!
    @IBOutlet weak var labelKisiAd: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
