//
//  ViewController.swift
//  Weather
//
//  Created by Artur Sokolov on 24/08/2019.
//  Copyright © 2019 Artur Sokolov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Private Properties
    let weatherUrl = "http://icomms.ru/inf/meteo.php?tid=24"

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchWeather()
    }

    // MARK: - Private Methods
    private func fetchWeather() {
        guard let url = URL(string: weatherUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            if let response = response {
//                print(response)
//            }
            
            guard let data = data else { return }
            do {
                let weather = try JSONDecoder().decode([Weather].self,
                                                       from: data)
                print(weather.first?.getDate() ?? "Something wrong")
                print(weather.first?.getTimeOfDay() ?? "Something wrong")
            } catch let error {
                print(error)
            }
        }.resume()
        
    }
}

