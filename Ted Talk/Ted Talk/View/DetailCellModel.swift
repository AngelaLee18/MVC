//
//  DetailModel.swift
//  Ted Talk
//
//  Created by Angela Lee on 02/09/2022.
//

import Foundation

struct DetailCellModel {
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
        description = talk.descript
        tags = Array(talk.tags)
    }
}
