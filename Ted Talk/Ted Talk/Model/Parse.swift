//
//  Parse.swift
//  Ted Talk
//
//  Created by Angela Lee on 23/08/2022.
//

import Foundation

public class Parse: ServiceProtocol {
    
    var fileName: String
    
    init(fileName: String = "tedTalks") {
        self.fileName = fileName
    }

    func parseTedTalk(_ completion: @escaping (Result<[TedTalkData], ServiceError>) -> Void ) {
        DispatchQueue.global(qos: .background).async {
            guard let fileLocation = Bundle.main.url(forResource: self.fileName, withExtension: "json") else {
                return completion(.failure(.fileNotFound))
            }
            do {
                let jsonData = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([TedTalkData].self, from:jsonData)
                    completion(.success(dataFromJson))
            } catch {
                completion(.failure(.parseError))
            }
        }
    }
    /*
    
    func parseTedTalk(_ tedTalks: String, _ completion: @escaping (Result<[TedTalkData], ParseError>) -> Void ) {
        let session = URLSession.shared
        let urlAsString = "https://gist.githubusercontent.com/gonzaloperretti/0e79c229a5de5bacdd07f402c1a3cefd/raw/975582a4389601caa90d21227446ef2838159176/tedTalks.json"
        let url = URL(string: urlAsString)
        
        guard let url = url else {
            return completion(.failure(.badURL))
        }
        session.dataTask(with: url) { data, response, error in
            if error != nil {
                return completion(.failure(.error))
            }
            guard let response = response as? HTTPURLResponse,(200...299).contains(response.statusCode) else {
                completion(.failure(.serverError))
                return
            }
            guard let data = data else {
            completion(.failure(.NotFound))
            return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([TedTalkData].self, from: data)
                completion(.success(dataFromJson))
            }catch {
                completion(.failure(.parseError))
            }
        }.resume()
    }*/
}

