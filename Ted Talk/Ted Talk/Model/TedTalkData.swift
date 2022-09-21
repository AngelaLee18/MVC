//
//  TedTalkData.swift
//  Ted Talk
//
//  Created by Angela Lee on 23/08/2022.
//

import Foundation
import RealmSwift

class TedTalkData: Object, Decodable {
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
        
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        comments = try values.decode(Int.self, forKey: .comments)
        descript = try values.decode(String.self, forKey: .descript)
        duration = try values.decode(Int.self, forKey: .duration)
        event = try values.decode(String.self, forKey: .event)
        film_date = try values.decode(Int.self, forKey: .film_date)
        languages = try values.decode(Int.self, forKey: .languages)
        main_speaker = try values.decode(String.self, forKey: .main_speaker)
        name = try values.decode(String.self, forKey: .name)
        num_speaker = try values.decode(Int.self, forKey: .num_speaker)
        published_date = try values.decode(Int.self, forKey: .published_date)
        speaker_occupation = try values.decode(String.self, forKey: .speaker_occupation)
        tags = try values.decode(List<String>.self, forKey: .tags)
        title = try values.decode(String.self, forKey: .title)
        url = try values.decode(String.self, forKey: .url)
        views = try values.decode(Int.self, forKey: .views)
    }
    
    override required init() {
        super.init()
    }
}

/*struct TedTalkData: Decodable {
    var comments: Int
    var description: String
    var duration: Int
    var event: String
    var film_date: Int
    var languages: Int
    var main_speaker: String
    var name: String
    var num_speaker: Int
    var published_date: Int
    var speaker_occupation: String
    var tags = List<String>()
    var title: String
    var url: String
    var views: Int
    
    enum CodingKeys: String, CodingKey {
        case comment
        case description
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
        
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        comments = try values.decode(Int.self, forKey: .comment)
        description = try values.decode(String.self, forKey: .description)
        duration = try values.decode(Int.self, forKey: .duration)
        event = try values.decode(String.self, forKey: .event)
        film_date = try values.decode(Int.self, forKey: .film_date)
        languages = try values.decode(Int.self, forKey: .languages)
        main_speaker = try values.decode(String.self, forKey: .main_speaker)
        name = try values.decode(String.self, forKey: .name)
        num_speaker = try values.decode(Int.self, forKey: .num_speaker)
        published_date = try values.decode(Int.self, forKey: .published_date)
        speaker_occupation = try values.decode(String.self, forKey: .speaker_occupation)
        tags = try values.decode(List<String>.self, forKey: .tags)
        title = try values.decode(String.self, forKey: .title)
        url = try values.decode(String.self, forKey: .url)
        views = try values.decode(Int.self, forKey: .views)
        
    }*/

