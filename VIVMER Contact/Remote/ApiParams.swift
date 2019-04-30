//
//  ApiParams.swift
//  Alamofire
//
//  Created by UziApel on 08/01/19.
//

import Foundation

struct ApiParams{
    static func weatherMalaysia() -> [String : String]{
        let params = ["q" : "Malaysia", "APPID" : ApiAuthEndpoint.appIdWeather]
        return params
    }
}
