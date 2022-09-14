//
//  ViewModelTedTalk.swift
//  Ted Talk
//
//  Created by Angela Lee on 08/09/2022.
//

import Foundation

class ViewModelTedTalk {
    
    //MARK: - Properties
    enum PickerOptions: String, CaseIterable {
        case event = "Event"
        case main_speaker = "Main Speaker"
        case title = "Title"
        case name = "Name"
        case description = "Description"
        case all = "All"
    }
    private let pickerOptions: [PickerOptions] = [.all, .event, .main_speaker, .title, .name, .description]
    private var manager: DataManager
    private var filterTedTalks: [TedTalkData] = [] {
        didSet {
            refreshTableView?()
        }
    }
    private var tedTalks: [TedTalkData] = []
    
    //MARK: - Init
    init(dataManager: DataManager = DataManager()) {
        manager = dataManager
    }
    //MARK: - Closures
    var loadTableView: (() -> ())?
    var refreshTableView: (() -> ())?
    
    
    // MARK: - Fetching funtion
    
    func fetchData() {
        manager.getDataTedTalks() { tedTalks in
            self.loadTableView?()
            self.filterTedTalks = tedTalks
            self.tedTalks = tedTalks
        }
    }
    
    //MARK: - TableViewController funtions
    func getNumberOfRow() -> Int {
        return filterTedTalks.count
    }
    
    func getTedTalk(indexPath: Int) -> TedTalksCellModel {
        return .init(talk: filterTedTalks[indexPath])
    }
    
    func getTedTalkDetails(selectedPath: Int) -> DetailCellModel {
        return .init(talk: filterTedTalks[selectedPath])
    }
    
    //MARK: - SearchBar and PickerView funtions
    func getPickerOptionCount() -> Int {
        return pickerOptions.count
    }
    
    func getPickerOption(row: Int) -> String {
        return pickerOptions[row].rawValue
    }
    
    func searchByFilter(searchText: String, picker: Int) {
        guard searchText != "" else {
            return
        }
        filterTedTalks = tedTalks.filter { talk in
            switch pickerOptions[picker] {
            case .event:
                return talk.event.lowercased().contains(searchText.lowercased())
            case .main_speaker:
                return talk.main_speaker.lowercased().contains(searchText.lowercased())
            case .title:
                return talk.title.lowercased().contains(searchText.lowercased())
            case .name:
                return talk.name.lowercased().contains(searchText.lowercased())
            case .description:
                return talk.description.lowercased().contains(searchText.lowercased())
                
            case .all:
                return talk.event.lowercased().contains(searchText.lowercased()) || talk.main_speaker.lowercased().contains(searchText.lowercased()) || talk.title.lowercased().contains(searchText.lowercased()) || talk.name.lowercased().contains(searchText.lowercased()) || talk.description.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
