//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Ahmed Osman on 24/01/2021.
//

import UIKit

class DayWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewOffset: CGFloat? {
        set {
            guard let x = newValue else { return }
            collectionView.performBatchUpdates({ [weak self] in
                self?.collectionView.contentOffset.x = x
            }, completion: nil)
        }
        get {
            return self.collectionView.contentOffset.x
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        collectionView.delegate = nil
        collectionView.dataSource = nil
        collectionView.tag = 0
        collectionViewOffset = nil
        self.collectionView.contentOffset.x = 0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib(nibName: K.Nib.timeWeatherNib, bundle: nil), forCellWithReuseIdentifier: K.CellIdentifiers.timeCellIdentifier)
    }
    
    func setup(date: String?, controller: UICollectionViewDataSource&UICollectionViewDelegate, row: Int) {
        self.dateLabel.text = date
        self.collectionView.tag = row
        self.collectionView.dataSource = controller
        self.collectionView.delegate = controller
        collectionView.reloadData()
    }
}
