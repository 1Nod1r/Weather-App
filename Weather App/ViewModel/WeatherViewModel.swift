//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Nodirbek on 17/05/22.
//

import Foundation

class WeatherViewModel {
    var didChange: (() -> Void)?
    var query: String? 
    var weather: WeatherData? {
        didSet {
            didChange?()
        }
    }

    func getWeather(){
        ApiCaller.shared.getData(query: query ?? "Tashkent") {[weak self] result in
            guard let self = self else { return }
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
