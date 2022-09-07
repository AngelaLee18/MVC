//
//  Protocols.swift
//  Ted Talk
//
//  Created by Angela Lee on 07/09/2022.
//

import Foundation

enum ServiceError: Error {
    case emptyData
    case parseError
    case serverError
    case clientError
    case badURL
    case error
    case fileNotFound
}

protocol ServiceProtocol {
    func parseTedTalk(_ completion: @escaping (Result<[TedTalkData], ServiceError>) -> Void )
}
