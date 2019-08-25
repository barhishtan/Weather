//
//  WeatherCell.swift
//  Weather
//
//  Created by Artur Sokolov on 25/08/2019.
//  Copyright © 2019 Artur Sokolov. All rights reserved.
//

import UIKit

class WeatherCell:
    UICollectionViewCell,
    UICollectionViewDelegate,
    UICollectionViewDataSource {
    
    // MARK: - IB Outlets
    @IBOutlet var collectionInCell: UICollectionView!
    
    // MARK: - Private Properties
    private let numberOfTimesOfDay = 4
    
    // MARK: - Public Properties
    var weatherData: [Weather]?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionInCell.delegate = self
        collectionInCell.dataSource = self
        
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return numberOfTimesOfDay
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "internalCell", for: indexPath) as! InternalCell
        
                cell.timeOfDayLabel.text = weatherData?.first?.getTimeOfDay()
                cell.temperatureLabel.text = weatherData?.first?.temp
                cell.windLabel.text = weatherData?.first?.wind
                cell.cloudLabel.text = weatherData?.first?.cloud
            
            return cell
    }
    
}
