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
    @Persisted var filmDate: Int
    @Persisted var languages: Int
    @Persisted var mainSpeaker: String
    @Persisted var name: String
    @Persisted var numberSpeaker: Int
    @Persisted var publishedDate: Int
    @Persisted var speakerOccupation: String
    @Persisted var tags = List<String>()
    @Persisted var title: String
    @Persisted var url: String
    @Persisted var views: Int
    
    enum CodingKeys: String, CodingKey {
        case comments
        case descript = "description"
        case duration
        case event
        case filmDate = "film_date"
        case languages
        case mainSpeaker = "main_speaker"
        case name
        case numberSpeaker = "num_speaker"
        case publishedDate = "published_date"
        case speakerOccupation = "speaker_occupation"
        case tags
        case title
        case url
        case views
    }
    
    convenience init(comments: Int, descript: String, duration: Int, event: String, filmDate: Int, languages: Int, mainSpeaker: String, name: String, numberSpeaker: Int, publishedDate: Int, speakerOccupation: String, tags: [String], title: String, url: String, views: Int) {
        self.init()
        self.comments = comments
        self.descript = descript
        self.duration = duration
        self.event = event
        self.filmDate = filmDate
        self.languages = languages
        self.mainSpeaker = mainSpeaker
        self.name = name
        self.numberSpeaker = numberSpeaker
        self.publishedDate = publishedDate
        self.speakerOccupation = speakerOccupation
        self.tags.append(objectsIn: tags)
        self.title = title
        self.url = url
        self.views = views
    }
}
