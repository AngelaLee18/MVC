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
    }
    
    func parseTedTalk(_ tedTalks: String, _ completion: @escaping (Result<[TedTalkData], ParseError>) -> Void ) {
        DispatchQueue.global(qos: .background).async {
            guard let fileLocation = Bundle.main.url(forResource: tedTalks, withExtension: "json") else {
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
}

