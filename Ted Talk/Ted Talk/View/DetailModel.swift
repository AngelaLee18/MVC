//
//  DetailModel.swift
//  Ted Talk
//
//  Created by Angela Lee on 02/09/2022.
//

import Foundation

struct DetailModel {
    let title: String
    let url: String
    let view: Int
    let date: Int
    let name: String
    let description: String
    let tags: [String]
    
    init(talk: TedTalkData) {
        title = talk.title
        url = talk.url 
        view = talk.views
        date = talk.film_date
        name = talk.name
        description = talk.description
        tags = talk.tags
    }
}
