//
//  DataManager.swift
//  Ted Talk
//
//  Created by Angela Lee on 25/08/2022.
//

import Foundation

public class DataManager {
    var fileName: String
    var tedTalks: [TedTalkData] = []
    func getDataTedTalks(completionHandler: @escaping ([TedTalkData]) -> Void) {
        Parse().parseTedTalk(fileName) { [weak self] result in DispatchQueue.main.async {
                switch result {
                case.success(let data):
                    self?.tedTalks = data
                    completionHandler(data)
                case.failure(_ ):
                    completionHandler([])
                }
            }
        }
    }
    init(fileName: String = "tedTalks") {
        self.fileName = fileName
    }

    func searchEnteredWord(searchText: String, picker: String) -> [TedTalkData] {
        var filterData: [TedTalkData] = []
        guard searchText != "" else {
            return tedTalks
        }
        filterData = tedTalks.filter { talk in
            switch picker {
            case "All":
                return talk.event.lowercased().contains(searchText.lowercased()) || talk.main_speaker.lowercased().contains(searchText.lowercased()) || talk.title.lowercased().contains(searchText.lowercased()) || talk.name.lowercased().contains(searchText.lowercased()) || talk.description.lowercased().contains(searchText.lowercased())
            case "Event":
                return talk.event.lowercased().contains(searchText.lowercased())
            case "Main speaker":
                return talk.main_speaker.lowercased().contains(searchText.lowercased())
            case "Title":
                return talk.title.lowercased().contains(searchText.lowercased())
            case "Name":
                return talk.name.lowercased().contains(searchText.lowercased())
            case "Description":
                return talk.description.lowercased().contains(searchText.lowercased())
                
            default:
                return talk.event.lowercased().contains(searchText.lowercased()) 
            }
        }
        return filterData
    }
}
