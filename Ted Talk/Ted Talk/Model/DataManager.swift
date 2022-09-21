//
//  DataManager.swift
//  Ted Talk
//
//  Created by Angela Lee on 25/08/2022.
//

import Foundation
import RealmSwift

public class DataManager {
    
    var service: ServiceProtocol
    var dataBase: DataBase
    private var delegate: DataManagerDelegate?
    
    init(service: ServiceProtocol = ServiceProvider(), realmDataBase: DataBase = RealmDB()) {
        self.service = service
        dataBase = realmDataBase
    }
    
    //MARK: - Get data of TedTalks
    func getDataTedTalks(completionHandler: @escaping ([TedTalkData]) -> Void) {
        if !(dataBase.isEmpty) {
            completionHandler(dataBase.getRealmData())
            self.service.parseTedTalk() { result in
                DispatchQueue.main.async {
                    switch result {
                    case.success(let talks):
                        self.dataBase.clearData(data: talks)
                        self.dataBase.persistData(data: talks)
                        self.delegate?.refreshData(data: talks)
                    case.failure(_ ):
                        break
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
