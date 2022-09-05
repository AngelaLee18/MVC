//
//  Parse.swift
//  Ted Talk
//
//  Created by Angela Lee on 23/08/2022.
//

import Foundation

public class Parse {
    enum ParseError: Error {
        case fileNotFound
        case parseError
        case serverError
        case clientError
    }
    
    func parseTedTalk(_ tedTalks: String, _ completion: @escaping (Result<[TedTalkData], ParseError>) -> Void ) {
        DispatchQueue.global(qos: .background).async {
            let session = URLSession.shared
            let url = URL(string: "https://gist.githubusercontent.com/gonzaloperretti/0e79c229a5de5bacdd07f402c1a3cefd/raw/975582a4389601caa90d21227446ef2838159176/tedTalks.json")
            session.dataTask(with: url!) { data, response, error in
                guard error == nil || data != nil else {
                    completion(.failure(.clientError))
                    return
                }
                do {
                    let jsonDecoder = JSONDecoder()
                    let dataFromJson = try jsonDecoder.decode([TedTalkData].self, from: data!)
                    completion(.success(dataFromJson))
                }catch {
                    completion(.failure(.parseError))
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    completion(.failure(.serverError))
                    return
                }
            }.resume()
        }
    }
}

