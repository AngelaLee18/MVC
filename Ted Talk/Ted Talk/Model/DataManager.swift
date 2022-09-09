//
//  DataManager.swift
//  Ted Talk
//
//  Created by Angela Lee on 25/08/2022.
//

import Foundation

public class DataManager {
    
    var tedTalks: [TedTalkData] = []
    var service: ServiceProtocol
    
    init(service: ServiceProtocol = ServiceProvider()) {
        self.service = service
    }
    
    //MARK: - Get data of TedTalks
    
    func getDataTedTalks(completionHandler: @escaping ([TedTalkData]) -> Void) {
        service.parseTedTalk() { [weak self] result in DispatchQueue.main.async {
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
    
    //MARK: - Filter
    
    func searchByFilter(searchText: String, picker: Int) -> [TedTalkData] {
        var filterData: [TedTalkData] = []
        guard searchText != "" else {
            return tedTalks
        }
        filterData = tedTalks.filter { talk in
            switch picker {
            case 1:
                return talk.event.lowercased().contains(searchText.lowercased())
            case 2:
                return talk.main_speaker.lowercased().contains(searchText.lowercased())
            case 3:
                return talk.title.lowercased().contains(searchText.lowercased())
            case 4:
                return talk.name.lowercased().contains(searchText.lowercased())
            case 5:
                return talk.description.lowercased().contains(searchText.lowercased())
                
            default:
                return talk.event.lowercased().contains(searchText.lowercased()) || talk.main_speaker.lowercased().contains(searchText.lowercased()) || talk.title.lowercased().contains(searchText.lowercased()) || talk.name.lowercased().contains(searchText.lowercased()) || talk.description.lowercased().contains(searchText.lowercased())
            }
        }
        return filterData
    }
}
