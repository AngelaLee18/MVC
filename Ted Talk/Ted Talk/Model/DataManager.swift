//
//  DataManager.swift
//  Ted Talk
//
//  Created by Angela Lee on 25/08/2022.
//

import Foundation

public class DataManager {
    
    private var service: ServiceProtocol
    private var dataBase: DataBase
    var delegate: DataManagerDelegate?
    
    init(service: ServiceProtocol = ServiceProvider(), dataBase: DataBase = RealmDB()) {
        self.service = service
        self.dataBase = dataBase
    }
    
    //MARK: - Get data of TedTalks
    func getDataTedTalks(completionHandler: @escaping ([TedTalkData]) -> Void) {
        if !dataBase.isEmpty {
            completionHandler(dataBase.getData())
            self.service.parseTedTalk() { result in
                DispatchQueue.main.async {
                    switch result {
                    case.success(let talks):
                        self.dataBase.clearData()
                        self.dataBase.persistData(data: talks)
                        self.delegate?.refreshData(data: talks)
                    case.failure(_ ):
                        return
                    }
                }
            }
        } else {
            service.parseTedTalk() { result in
                DispatchQueue.main.async {
                    switch result {
                    case.success(let talks):
                        self.dataBase.persistData(data: talks)
                        completionHandler(talks)
                    case.failure(_ ):
                        completionHandler([])
                    }
                }
            }
        }
    }
}
