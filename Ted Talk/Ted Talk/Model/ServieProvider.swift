//
//  ServieProvider.swift
//  Ted Talk
//
//  Created by Angela Lee on 07/09/2022.
//

import Foundation

class ServiceProvider: ServiceProtocol {
    
    struct Configuration {
        static let urlAsString = "https://gist.githubusercontent.com/gonzaloperretti/0e79c229a5de5bacdd07f402c1a3cefd/raw/975582a4389601caa90d21227446ef2838159176/tedTalks.json"
    }
    func parseTedTalk(_ completion: @escaping (Result<[TedTalkData], ServiceError>) -> Void) {
        let session = URLSession.shared
        let url = URL(string: Configuration.urlAsString)
        
        guard let url = url else {
            return completion(.failure(.badURL))
        }
        session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                return completion(.failure(.error))
            }
            guard let response = response as? HTTPURLResponse,(200...299).contains(response.statusCode) else {
                completion(.failure(.serverError))
                return
            }
            guard let data = data else {
                completion(.failure(.emptyData))
            return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([TedTalkData].self, from: data)
                completion(.success(dataFromJson))
            }catch {
                completion(.failure(.error))
            }
        }.resume()
    }
    
    
}
