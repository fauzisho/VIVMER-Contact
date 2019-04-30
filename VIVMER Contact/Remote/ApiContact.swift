//
//  ApiContact.swift
//  Alamofire
//
//  Created by UziApel on 08/01/19.
//

import Foundation

import Alamofire
import SwiftyJSON

open class ApiContact {
    open class func getContact(completion: @escaping (ApiResponse)->()){
        Alamofire.request(ApiAuthEndpoint.listContact, method: .get, parameters: ApiParams.weatherMalaysia()).responseJSON { (response)->Void in
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
    open class func getContactGender(gender : String,completion: @escaping (ApiResponse)->()){
        Alamofire.request(ApiAuthEndpoint.listContact + "&&gender=" + gender, method: .get, parameters: ApiParams.weatherMalaysia()).responseJSON { (response)->Void in
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
