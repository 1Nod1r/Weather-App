//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Nodirbek on 17/05/22.
//

import Foundation

class WeatherViewModel {
    var didChange: (() -> Void)?
    var weather: WeatherData? {
        didSet {
            didChange?()
        }
    }
    var query: String?

    func getWeather(){
        ApiCaller.shared.getData(query: "london") { result in
            switch result {
            case .success(let weather):
                self.weather = weather
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfRows() -> Int {
        return weather?.list.count ?? 0
    }
    
    func item(for index: Int) -> List? {
        guard let weather = weather else {
            return nil
        }
        return weather.list[index]
    }
    
}
