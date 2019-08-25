//
//  ViewController.swift
//  Weather
//
//  Created by Artur Sokolov on 24/08/2019.
//  Copyright © 2019 Artur Sokolov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var weatherCV: UICollectionView!

    // MARK: - Private Properties
    private let weatherUrl = "http://icomms.ru/inf/meteo.php?tid=24"
    private var weatherData: [Weather]?
    private let numberOfTimesOfDay = 4

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherCV.delegate = self
        weatherCV.dataSource = self
        fetchWeatherData()
    }

    // MARK: - Private Methods
 
    private func fetchWeatherData() {
        
        guard let url = URL(string: weatherUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            do {
                self.weatherData = try JSONDecoder().decode([Weather].self, from: data)
            } catch let error {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.weatherCV.reloadData()
            }
            
        }.resume()
        
    }
}
// MARK: - Collection view data sourse and delegate
extension ViewController:
    UICollectionViewDataSource,
    UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (weatherData?.count ?? numberOfTimesOfDay)
                                        / numberOfTimesOfDay
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath)
        -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                    withReuseIdentifier: "weatherHeader",
                                                    for: indexPath) as! WeatherHeaderView
            
        if let weatherDate = weatherData?[indexPath.section *
                                            numberOfTimesOfDay].getDate() {
            header.dateLabel.text = weatherDate
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell",
                                                      for: indexPath) as! WeatherCell
        
        cell.weatherData = weatherData
        
        return cell
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 125)
    }
    
}
