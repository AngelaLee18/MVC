//
//  SearchBarAndPickerViewTest.swift
//  Ted TalkTests
//
//  Created by Angela Lee on 31/08/2022.
//

import XCTest
@testable import Ted_Talk

class SearchBarAndPickerViewTest: XCTestCase {
    
    var sut: DataManager!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DataManager()
        sut.tedTalks = [
            TedTalkData(comments: 10, description: "description1", duration: 5, event: "event", film_date: 14, languages: 5, main_speaker: "speaker1", name: "name1", num_speaker: 1, published_date: 4, speaker_occupation: "occupation", tags: ["Children", "education"], title: "title1", url: "url1", views: 32432),
            TedTalkData(comments: 4, description: "description2", duration: 10, event: "event", film_date: 16, languages: 3, main_speaker: "speaker1", name: "name2", num_speaker: 1, published_date: 24, speaker_occupation: "occupation", tags: ["Culture", "Science"], title: "title2", url: "url2", views: 0),
            TedTalkData(comments: 10, description: "description3", duration: 32, event: "event", film_date: 1, languages: 20, main_speaker: "speaker3", name: "name3", num_speaker: 5, published_date: 4, speaker_occupation: "occupation3", tags: ["Technology", "Cars"], title: "title", url: "url", views: 0)
        ]
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testSearchEvent() {
        //
        var searchResult: [TedTalkData] = []

        searchResult = sut.searchEnteredWord(searchText: "event", picker: "Event")
        XCTAssertEqual(searchResult.count, 3, "3 event matched with TED2006")
        searchResult = sut.searchEnteredWord(searchText: "speaker1", picker: "Event")
        XCTAssertEqual(searchResult.count, 0, "There is not event called speacker1")
        searchResult = sut.searchEnteredWord(searchText: "nam", picker: "Name")
        XCTAssertEqual(searchResult.count, 3, "There is 3 matched when search nam in Name")
        XCTAssertEqual(searchResult[0].name, "name1", "The name of the main speaker of the first event is name1")
    }
}
