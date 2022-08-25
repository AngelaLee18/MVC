//
//  Parse.swift
//  Ted Talk
//
//  Created by Angela Lee on 23/08/2022.
//

import Foundation

public class Parse {
    
    func parseTedTalk(_ tedTalks: String, _ completion: @escaping (Result<[TedTalkData], Error>) -> Void ) {
        DispatchQueue.global(qos: .background).async {
            guard let fileLocation = Bundle.main.url(forResource: tedTalks, withExtension: "json") else {
                return completion(.success([]))
            }
            do {
                let jsonData = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([TedTalkData].self, from:jsonData)
                    completion(.success(dataFromJson))
            } catch {
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
    }
}

