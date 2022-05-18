//
//  APICaller.swift
//  Weather App
//
//  Created by Nodirbek on 17/05/22.
//

import Foundation

final class ApiCaller {
    
    static let shared = ApiCaller()
    
    func getData(query: String, completion: @escaping (Result<WeatherData, Error>) -> Void){
        let headers = [
            "X-RapidAPI-Host": "community-open-weather-map.p.rapidapi.com",
            "X-RapidAPI-Key": "b64c665322mshb98ae43d28570a4p1837dfjsna04b9476fea8"
        ]
        let urlString = "https://community-open-weather-map.p.rapidapi.com/climate/month?q=%@&units=metric"
        let url = String(format: urlString, query)
        let request = NSMutableURLRequest(url:  NSURL(string: url)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, _, error) -> Void in
            guard let data = data, error == nil else {
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(WeatherData.self, from: data)
                completion(.success(result))
            } catch {
                print(error.localizedDescription)
            }
        })

        dataTask.resume()
    }
    
}
