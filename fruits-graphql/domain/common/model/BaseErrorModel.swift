//
//  BaseErrorModel.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 05/09/22.
//

import Foundation
import Apollo

private let graphqlCodeDict: [String: BaseErrorModel.ErrorCode] = [
    "Bad Request": .badRequest,
    "Internal Error": .internalError,
    "Unknown": .unknown,
    "Unauthorized": .unauthorized,
    "Not Found": .notFound,
    "Not Implemented": .notImplemented,
    "Unavailable": .unavailable,
    "Unprocessable Entity": .unprocessable
]

struct BaseErrorModel: Error {
    
    enum ErrorCode: String {
        case badRequest = "Bad Request"
        case internalError = "Internal Error"
        case unauthorized = "Unauthorized"
        case notFound = "Not Found"
        case unknown = "Unknown"
        case notImplemented = "Not Implemented"
        case unavailable = "Unavailable"
        case unprocessable = "Unprocessable Entity"
    }

    let errors: Array<(code: ErrorCode, message: String)>
    
    static func convertGraphqlError(errors: [GraphQLError]?) -> BaseErrorModel {
        var errorList: Array<(code: ErrorCode, message: String)> = []
        
        if let errors = errors {
            errors.forEach { error in
                if let extensions = error.extensions {
                    if let childErrors = extensions["errors"] as? Array<[String: Any]> {
                         childErrors.forEach{ childError in
                             if let childExtensions = childError["extensions"] as? [String: Any] {
                                 let rawCode = childExtensions["code"] as? String ?? ErrorCode.unknown.rawValue
                                 let rawMessage = childExtensions["message"] as? String ?? "Unknown Error"
                                 let code = graphqlCodeDict[rawCode] ?? .unknown
                                 errorList.append((code: code, message: rawMessage))
                             }
                         }
                    }
                }
            }
            
            return BaseErrorModel(errors: errorList)
        } else {
            return BaseErrorModel(errors: [(code: .unknown, message: "Unknown Error")])
        }
    }
    
    static func createSingleError(message: String) -> BaseErrorModel {
        return BaseErrorModel(errors: [(code: .unknown, message: message)])
    }
}

extension Error {
    func convertToBaseErrorModel() -> BaseErrorModel {
        return BaseErrorModel(errors: [(code: .unknown, message: self.localizedDescription)])
    }
}
