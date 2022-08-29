//
//  DataManager.swift
//  Ted Talk
//
//  Created by Angela Lee on 25/08/2022.
//

import Foundation

//let json 
public class DataManager {
    var tedTalks: [TedTalkData] = []
    func getDataTedTalks(completionHandler: @escaping ([TedTalkData]) -> Void) {
        Parse().parseTedTalk("tedTalks") { result in DispatchQueue.main.async {
                switch result {
                case.success(let data):
                    self.tedTalks = data
                    completionHandler(self.tedTalks)
                case.failure(_ ):
                    completionHandler([])
                }
            }
        }
    }
}
