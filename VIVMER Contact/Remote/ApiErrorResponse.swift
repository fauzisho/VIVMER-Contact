//
//  ApiErrorResponse.swift
//  Alamofire
//
//  Created by UziApel on 08/01/19.
//

import SwiftyJSON

struct ApiErrorResponse {
    static func processAPIFailed(data: Any) -> APIError {
        let dataJSON = JSON(data)
        let errorMessage = dataJSON["error"]["message"].stringValue
        let error = dataJSON["error"].stringValue
        let message = (errorMessage.isEmpty) ? error : errorMessage
        let result = APIError { api in
            api.message = (message.isEmpty) ? "CAN'T_PROCESS" : message
        }
        return result
    }
}

class APIError {
    var message: String = ""
    typealias BuilderClosure = (APIError) -> ()
    init(buildError: BuilderClosure) {
        buildError(self)
    }
}
