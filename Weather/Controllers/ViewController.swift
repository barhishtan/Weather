//
//  ViewController.swift
//  Weather
//
//  Created by Artur Sokolov on 24/08/2019.
//  Copyright © 2019 Artur Sokolov. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var weatherCV: UICollectionView!

    // MARK: - Private Properties
    private let weatherUrl = "http://icomms.ru/inf/meteo.php?tid=24"
    private var weatherData: [Weather]? = []
    private let numberOfTimesOfDay = 4

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherCV.delegate = self
        weatherCV.dataSource = self
        fetchAlomafireWeatherData()
    }

}

// MARK: - JSON Parse
extension ViewController {
    
    private func fetchAlomafireWeatherData() {
        guard let url = URL(string: weatherUrl) else { return }
        
        request(url).validate().responseJSON { dataResponse in
            
            switch dataResponse.result {
            case .success(let value):
                
                guard let jsonData = value as? Array<[String: Any]> else { return }
                
                for dictWeather in jsonData {
                    let weather = Weather(date: dictWeather["date"] as? String,
                                          tod: dictWeather["tod"] as? String,
                                          temp: dictWeather["temp"] as? String,
                                          wind: dictWeather["wind"] as? String,
                                          cloud: dictWeather["cloud"] as? String)
                    
                    self.weatherData?.append(weather)
                }
                
                DispatchQueue.main.async {
                    self.weatherCV.reloadData()
                    
                }
            case .failure(let error):
                print(error)
            }
        }
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
        cell.numberOfSection = indexPath.section
        
        return cell
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 150)
    }
    
}
