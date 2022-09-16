//
//  TedTalkData.swift
//  Ted Talk
//
//  Created by Angela Lee on 23/08/2022.
//

import Foundation
import RealmSwift

@objcMembers class TedTalkData: Object, Codable {
    @Persisted var comments: Int
    @Persisted var descrip: String
    @Persisted var duration: Int
    @Persisted var event: String
    @Persisted var film_date: Int
    @Persisted var languages: Int
    @Persisted var main_speaker: String
    @Persisted var name: String
    @Persisted var num_speaker: Int
    @Persisted var published_date: Int
    @Persisted var speaker_occupation: String
    @Persisted var tags = List<String>()
    @Persisted var title: String
    @Persisted var url: String
    @Persisted var views: Int
}
