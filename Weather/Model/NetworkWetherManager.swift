//
//  NetworkWetherManager.swift
//  Weather
//
//  Created by Валентина Лучинович on 10.01.2022.
//

import Foundation

struct  NetworkWetherManager {
    func fetchCurrentWeather(forCity city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        // Преобразуем строку в URL
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        // Создаем запрос
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                self.parseJSON(withData: data)
            }
        }
        task.resume()
    }
    
    // Метод отвечающий за парсинг JSON
    func parseJSON(withData data: Data) {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            print(currentWeatherData.main.temp)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
