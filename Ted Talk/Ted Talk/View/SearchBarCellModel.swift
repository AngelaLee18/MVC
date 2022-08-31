//
//  SearchBarCellModel.swift
//  Ted Talk
//
//  Created by Angela Lee on 29/08/2022.
//

import Foundation

struct SearchBarCellModel {
    let event: String
    let main_speaker: String
    let title: String
    let name: String
    let description: String
    
    init(SearchInfo: TedTalkData) {
        event = SearchInfo.event
        main_speaker = SearchInfo.main_speaker
        title = SearchInfo.title
        name = SearchInfo.name
        description = SearchInfo.description
    }
    
    
}
