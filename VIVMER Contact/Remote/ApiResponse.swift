//
//  ApiResponse.swift
//  Alamofire
//
//  Created by UziApel on 08/01/19.
//

import Foundation

public enum ApiResponse {
    case succeed(value: Any?)
    case failed(value: String)
    case onProgress(progress: Double)
}

public enum RequestResult<T>{
    case done(T)
    case failed(message: String)
}

public enum RequestProgressResult<T>{
    case done(T)
    case failed(message: String)
    case onProgress(progress: Double)
}
