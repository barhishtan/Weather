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
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout{
    
    // MARK: - IB Outlets
    @IBOutlet var collectionInCell: UICollectionView!
    
    // MARK: - Private Properties
    private let numberOfTimesOfDay = 4
    
    // MARK: - Public Properties
    var weatherData: [Weather]?
    var numberOfSection: Int!
    
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
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "internalCell",
                                                      for: indexPath) as! InternalCell
        
            let index = indexPath.row + numberOfTimesOfDay * numberOfSection
            
            cell.timeOfDayLabel.text = weatherData?[index].getTimeOfDay()
            cell.temperatureLabel.text = weatherData?[index].temp
            cell.windLabel.text = "Ветер" + " " + (weatherData?[index].wind  ?? " ")
            cell.cloudLabel.text = weatherData?[index].cloud
            
            cell.layer.shadowRadius = 5
            cell.layer.shadowOpacity = 0.3
            cell.layer.shadowOffset = CGSize(width: 3, height: 3)
            cell.clipsToBounds = false
            
            return cell
    }
    
    // MARK: -  UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 125)
    }
    
}
