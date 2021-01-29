//
//  WeatherCollectionCell.swift
//  Weather
//
//  Created by Ahmed Osman on 24/01/2021.
//

import UIKit

class TimeWeatherCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timeLabel.text = nil
        iconImage.image = nil
        tempLabel.text = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(time: String?, icon: String?, temp: String?) {
        self.timeLabel.text = time
        self.iconImage.setImage(url: icon ?? "")
        self.tempLabel.text = temp
    }
}
