//
//  ModelForForecast.swift
//  HW
//
//  Created by Artem Tsolov on 21.11.2020.
//

import Foundation

struct ModelForForecast {
    let temp: Double?
    let dt_txt: String?
   


    
    init?(data: NSDictionary){
        guard let main = data["main"] as? NSDictionary,
        let temp = main["temp"] as? Double,
            
        let dt_txt = data["dt_txt"] as? String else {
            return nil
        }
    
        self.dt_txt = dt_txt
        self.temp = temp
        
    }
    
}
