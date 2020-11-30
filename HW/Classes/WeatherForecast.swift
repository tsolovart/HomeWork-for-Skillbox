//
//  WeatherForecast.swift
//  HW
//
//  Created by Artem Tsolov on 16.11.2020.
//

import Foundation
import Alamofire
import RealmSwift

class WeatherForecast{
    
    var currentWeather = CurrentWeather()
    
    func loadForecastForFiveDay(completion: @escaping([ModelForForecast]) -> Void){
        let urlForFiveDay = URLAddress().addressForFiveDay
        
        var weather: [ModelForForecast] = []
        
        AF.request(urlForFiveDay).responseJSON
            { response in
            switch response.result {
                case .success(let value):
                    if let jsonDict = value as? NSDictionary{

                       if let list = jsonDict["list"] as? NSArray {
                                print(list)
                        
                        
                                
                        for data in list where data is NSDictionary{
                            if let forecast = ModelForForecast(data: data as! NSDictionary) {
                                if self.testDate(date: forecast.dt_txt ?? "") {
                                    weather.append(forecast)
                                }
                            }
                        }
                    }
                }
                case .failure(let error): break
                    
                }
                DispatchQueue.main.async{
                    completion (weather)
              }
        }
            
}
    
    func testDate(date: String) -> Bool {
        let strArray = date.split(separator: " ")
        if strArray[1] == "12:00:00" {
            return true
        } else {
            return false
        }
    }
    
    func loadCurrentForecast(completion: @escaping(String, Double) -> Void){
        
        var name = ""
        var temp = 0.0
        
        let url = URLAddress()
        AF.request(url.address).responseJSON
            { response in
            switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any] {
                        if let main = json["main"] as? NSDictionary {
                        temp = main["temp"] as? Double ?? 0.0
                        }
                        if let name1 = json ["name"] {
                         name = (name1 as? String)!
                            }
                    }
                case .failure(let error): break
                   
                }
                DispatchQueue.main.async {
                    completion (name, temp)
            }

            
        }
}
}

