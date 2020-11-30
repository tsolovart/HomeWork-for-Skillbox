//
//  ForecastRealm.swift
//  HW
//
//  Created by Artem Tsolov on 16.11.2020.
//

import Foundation
import RealmSwift


class CurrentWeather: Object {
    @objc dynamic var city = ""
    @objc dynamic var temp = ""
    
}

class ForecastForFaveDay: Object {
    @objc dynamic var temp = ""
    @objc dynamic var date = ""
    
}
    

class Persistence3 {
    static let shared = Persistence3()
    
    
    let realm = try! Realm()
//    let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    func saveForecast(city: CurrentWeather, temp: CurrentWeather){
        
        try! realm.write {
            realm.add(city)
            realm.add(temp)
        }
    }
    func saveForecastForFiveDay(item: ForecastForFaveDay){
        
        try! realm.write {
            realm.add(item)

        }
    }
    
    func obtainForecast() -> Results<CurrentWeather> {
        let weather = realm.objects(CurrentWeather.self)
        print (weather)
        
        return weather
    }
    
    func obtainForecastForFiveDay() -> Results<ForecastForFaveDay> {
        let weather = realm.objects(ForecastForFaveDay.self)
        print (weather)
        
        return weather
    }
    
    func deleteAll() {
        
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    
   
    
    
}
