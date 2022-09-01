//
//  TedTalksCellModel.swift
//  Ted Talk
//
//  Created by Angela Lee on 29/08/2022.
//

import Foundation

struct TedTalksCellModel {
    let description: String
    let title: String
    
    init(talk: TedTalkData) {
        description = talk.description
        title = talk.title
    }
}

