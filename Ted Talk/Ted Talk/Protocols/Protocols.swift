//
//  Protocols.swift
//  Ted Talk
//
//  Created by Angela Lee on 07/09/2022.
//

import Foundation
import RealmSwift

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

protocol DataBase {
    var isEmpty: Bool { get }
    func persistData(data: [TedTalkData])
    func getRealmData() -> [TedTalkData]
    func clearData()
}

protocol DataManagerDelegate {
    func refreshData(data: [TedTalkData])
}
