//
//  CodableResultMapper.swift
//  SimpleNetworkingSimple
//
//  Created by Tatiana Sosina on 16.04.2022.
//

import Foundation

typealias RemoteServiceResult<T> = Result<T, Error>

struct CodableResultMapper {
    func map<ResponseType: Codable>(_ result: NetworkRequestResult) -> RemoteServiceResult<ResponseType> {
        if let error = result.error {
            return .failure(error)
        } else {
            if let data = result.data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ResponseType.self, from: data)
                    return .success(result)
                } catch {
                    return .failure(error)
                }
            } else {
                return .failure(NetworkError.unexpectedServerResponse)
            }
        }
    }
}

struct NetworkRequestResult {
    public let data: Data?
    public let error: Error?
}

enum NetworkError: Error {
    case noInternetConnection
    case invalidURLRequest
    case unacceptedHTTPStatusCode
    case unexpectedServerResponse
}
