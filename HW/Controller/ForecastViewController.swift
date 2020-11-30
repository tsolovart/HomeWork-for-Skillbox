//
//  ForecastViewController.swift
//  HW
//
//  Created by Artem Tsolov on 16.11.2020.
//

import UIKit
import RealmSwift
import Alamofire

class ForecastViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: Results<CurrentWeather>!
    var weather: [ModelForForecast] = []
    var forecastForFiveDay: Results<ForecastForFaveDay>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        currentWeather = Persistence3.shared.obtainForecast()
        
        if let data = currentWeather?.first {
            cityLabel.text = data.city
            tempLabel.text = "\(data.temp)"
        }
        
        forecastForFiveDay = Persistence3.shared.obtainForecastForFiveDay()
        
       
        saveWeather()
        saveWeatherFor5Day()

        
    
    }
    override func viewDidAppear (_ animated: Bool) {
        super.viewDidAppear (animated)
        
        Persistence3.shared.deleteAll()
        
        currentWeather = Persistence3.shared.obtainForecast()
        
        
        forecastForFiveDay = Persistence3.shared.obtainForecastForFiveDay()
        
    }
    
    
    func saveWeather(){

        WeatherForecast().loadCurrentForecast{ (name, temp) in
            self.cityLabel.text = name
            self.tempLabel.text = "\(temp)"
            
            
            let currentWeather = CurrentWeather()
            currentWeather.city = name
            currentWeather.temp = "\(temp)"
             Persistence3.shared.saveForecast(city: currentWeather, temp: currentWeather)
       }
    }
        
        func saveWeatherFor5Day(){
            
            WeatherForecast().loadForecastForFiveDay{ weather in
            self.weather = weather
                
            for item in weather {
                let forecast = ForecastForFaveDay()
                var temperature = "\(item.temp ?? 0)"
                
                forecast.temp = temperature
                forecast.date = item.dt_txt ?? ""
                Persistence3.shared.saveForecastForFiveDay(item: forecast)
            }
    
                
                self.forecastForFiveDay = Persistence3.shared.obtainForecastForFiveDay()
            self.tableView.reloadData()
        }
            
        }
        
        
    }
    

extension ForecastViewController: UITableViewDataSource{
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastForFiveDay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as! ForecastCell
        
        let model = forecastForFiveDay[indexPath.row]
       
        cell.dayLabel.text = model.date
        cell.temperatureLabel.text = model.temp
        return cell

        
        
        
        
    
        
    }
}
