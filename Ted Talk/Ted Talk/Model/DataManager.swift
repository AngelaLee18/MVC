//
//  DataManager.swift
//  Ted Talk
//
//  Created by Angela Lee on 25/08/2022.
//

import Foundation

public class DataManager {
    
    var service: ServiceProtocol
    
    init(service: ServiceProtocol = ServiceProvider()) {
        self.service = service
    }
    
    //MARK: - Get data of TedTalks
    func getDataTedTalks(completionHandler: @escaping ([TedTalkData]) -> Void) {
        service.parseTedTalk() { result in DispatchQueue.main.async {
                switch result {
                case.success(let data):
                    completionHandler(data)
                case.failure(_ ):
                    completionHandler([])
                }
            }
        }
    }
}
