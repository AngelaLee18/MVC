//
//  DataBase.swift
//  Ted Talk
//
//  Created by Angela Lee on 15/09/2022.
//

import Foundation
import RealmSwift

class RealmDB: DataBase {
    
    private let realm: Realm
    
    required init() {
        do {
            realm = try Realm()
        } catch {
            print("error: \(error)")
            fatalError("Unable to create an Realm instance")
        }
    }

    func persistData(data: [TedTalkData]) {
        do {
            try realm.write({
                realm.add(data)
            })
        } catch {
            print("Error: \(error)")
        }
    }
    
    
    func getRealmData() -> [TedTalkData] {
        return Array(realm.objects(TedTalkData.self))
    }
    
    func clearData(data: [TedTalkData]) {
        do {
            try realm.write({
                realm.delete(data)
            })
        } catch {
            print("Error: \(error)")
        }
    }
}
