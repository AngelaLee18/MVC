//
//  TedTalkData.swift
//  Ted Talk
//
//  Created by Angela Lee on 23/08/2022.
//

import Foundation
import RealmSwift

class TedTalkData: Object, Codable {
    @Persisted var comments: Int
    @Persisted var descript: String
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
    
    enum CodingKeys: String, CodingKey {
        case comments
        case descript = "description"
        case duration
        case event
        case film_date
        case languages
        case main_speaker
        case name
        case num_speaker
        case published_date
        case speaker_occupation
        case tags
        case title
        case url
        case views
    }
    
    convenience init(comments: Int, descript: String, duration: Int, event: String, film_date: Int, languages: Int, main_speaker: String, name: String, num_speaker: Int, published_date: Int, speaker_occupation: String, tags: [String], title: String, url: String, views: Int) {
        self.init()
        self.comments = comments
        self.descript = descript
        self.duration = duration
        self.event = event
        self.film_date = film_date
        self.languages = languages
        self.main_speaker = main_speaker
        self.name = name
        self.num_speaker = num_speaker
        self.published_date = published_date
        self.speaker_occupation = speaker_occupation
        self.tags.append(objectsIn: tags)
        self.title = title
        self.url = url
        self.views = views
    }
}
