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
}

