//
//  URLAdress.swift
//  HW
//
//  Created by Artem Tsolov on 16.11.2020.
//

import Foundation

class URLAddress {
    
    let address = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=556ffcfd7ba133b5d141595653a4f8cf")!
    
    let addressForFiveDay = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=Moscow&appid=556ffcfd7ba133b5d141595653a4f8cf")!

}
