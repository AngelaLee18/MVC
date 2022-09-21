//
//  DataBase.swift
//  Ted Talk
//
//  Created by Angela Lee on 15/09/2022.
//

import Foundation
import RealmSwift

public class RealmDB: DataBase {
    
    let realm: Realm
    
    public init() {
        do {
            realm = try Realm()
        } catch {
            print("error: \(error)")
            fatalError("Unable to create an Realm instance")
        }
    }
    
    var isEmpty: Bool { return realm.isEmpty }
    
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
