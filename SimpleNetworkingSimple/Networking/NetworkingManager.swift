//
//  NetworkingManager.swift
//  SimpleNetworkingSimple
//
//  Created by Tatiana Sosina on 16.04.2022.
//

import Foundation

protocol Networking {
    
    /// Получить новости
    func getNews()
}

final class NetworkingManager: Networking {
    
    private var session = URLSession.shared
    
    func getNews() {
        let networkRequest = NetworkRequest(baseUrl: "https://api.spaceflightnewsapi.net",
                                            path: "/v3/info",
                                            httpMethod: .get)
        guard let networkURLRequest = URLRequest(networkRequest) else { return }
        
        session.dataTask(with: networkURLRequest) { data, response, error in
            if let error = error {
                
            }
            let mappedResult: RemoteServiceResult<NewsModel> = CodableResultMapper().map(data)
        }
    }
}
