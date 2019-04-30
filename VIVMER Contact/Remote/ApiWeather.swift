//
//  Api.swift
//  Alamofire
//
//  Created by UziApel on 08/01/19.
//

import Alamofire
import SwiftyJSON

open class ApiWeather {
    open class func getWeathers(completion: @escaping (ApiResponse)->()){
        Alamofire.request(ApiAuthEndpoint.forcast, method: .get, parameters: ApiParams.weatherMalaysia()).responseJSON { (response)->Void in
            if response.result.value != nil {
                if (response.response?.statusCode)! >= 300 {
                    let error = ApiErrorResponse.processAPIFailed(data: response.result.value!)
                    completion(ApiResponse.failed(value: error.message))
                } else {
                    completion(ApiResponse.succeed(value: response.result.value!))
                }
            } else {
                completion(ApiResponse.failed(value: response.result.error!.localizedDescription))
            }
        }
    }
}
