//
//  Weather.swift
//  Weather
//
//  Created by Artur Sokolov on 24/08/2019.
//  Copyright © 2019 Artur Sokolov. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    
    // MARK: - Properties
    private let date: String?
    private let tod: String?
    let temp: String?
    let wind: String?
    let cloud: String?
    
    // MARK: - Public Methods
    func getDate() -> String {
        
        guard let someDate = date else {
            return "Неверная дата"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: someDate)!
        
        dateFormatter.dateFormat = "dd MMMM y"
        dateFormatter.locale = Locale(identifier: "ru")
        let stringDate = dateFormatter.string(from: date)
        
        return stringDate
    }
    
    func getTimeOfDay() -> String {
        
        var timeOfDay = tod
        
        switch timeOfDay {
        case "0":
            timeOfDay = "Ночь"
        case "1":
            timeOfDay = "Утро"
        case "2":
            timeOfDay = "День"
        case "3":
            timeOfDay = "Вечер"
        default:
            timeOfDay = "Неверный формат"
        }
        
        return timeOfDay!
    }
}
