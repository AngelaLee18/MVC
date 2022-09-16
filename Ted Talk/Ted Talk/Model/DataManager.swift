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
    
    init(service: ServiceProtocol = ServiceProvider(), dataBase: DataBase = DataBase()) {
        self.service = service
        self.dataBase = dataBase
    }
    
    //MARK: - Get data of TedTalks
    func getDataTedTalks(completionHandler: @escaping ([TedTalkData]) -> Void) {
        //Verificar datos de realm y retornar y en backgraound
        //Realm delegate para refrezcar los datos nuevos
        //Recargar los datos nuevos
        service.parseTedTalk() { result in  DispatchQueue.main.async { //GetNewData llamada al funcion
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
