//
//  ApiEndpoint.swift
//  Alamofire
//
//  Created by UziApel on 08/01/19.
//

import Foundation

struct ApiAuthEndpoint{
    
    static var baseUrlWeather : String {
        get{
            return "http://api.openweathermap.org/data/2.5"
        }
    }
    
    static var baseContact : String {
        get{
            return "https://randomuser.me/api/"
        }
    }
    
    
    /////// WEATHER
    static var forcast : String {
        get{
            return baseUrlWeather + "/forecast"
        }
    }
    
    static var appIdWeather : String {
        get{
            return "6522dc760f867406ab83d904b618b428"
        }
    }
    
    
    ////// CONTACT
    static var listContact : String {
        get {
            return baseContact + "/?results=500"
        }
    }
}
