//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Nodirbek on 17/05/22.
//

import Foundation

class WeatherViewModel {
    var didChange: (() -> Void)?
    var weather: WeatherData?
    private var list: [List] = [] {
        didSet {
            didChange?()
        }
    }
    var query: String?
    
    func getList(){
        ApiCaller.shared.getList(query: "london") { result in
            switch result {
            case .success(let list):
                self.list = list
            case .failure(let error):
                print(error)
            }
        }
    }
    
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
        return list.count
    }
    
    func item(for index: Int) -> List{
        return list[index]
    }
    
}
