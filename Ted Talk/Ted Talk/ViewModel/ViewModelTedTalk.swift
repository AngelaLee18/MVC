//
//  ViewModelTedTalk.swift
//  Ted Talk
//
//  Created by Angela Lee on 08/09/2022.
//

import Foundation

class ViewModelTedTalk {
    
    //MARK: - Properties
    private let pickerOptions = ["All", "Event", "Main speaker", "Title", "Name", "Description"]
    private var manager: DataManager = DataManager()
    private var tedTalks: [TedTalkData] = [] {
        didSet {
            refreshTableView?()
        }
    }
    
    //MARK: - Closures
    var loadTableView: (() -> ())?
    var refreshTableView: (() -> ())?
    
    
    // MARK: - Fetching funtion
    
    func fetchData() {
        manager.getDataTedTalks() { tedTalks in
            self.loadTableView?()
            self.tedTalks = tedTalks
        }
    }
    
    //MARK: - TableViewController funtions
    func getNumberOfRow() -> Int {
        return tedTalks.count
    }
    
    func getTedTalk(indexPath: IndexPath) -> TedTalksCellModel {
        return .init(talk: tedTalks[indexPath.row])
    }
    
    func getTedTalkDetails(selectedPath: IndexPath) -> DetailCellModel {
        return .init(talk: tedTalks[selectedPath.row])
    }
    
    //MARK: - SearchBar and PickerView funtions
    func getPickerOptionCount() -> Int {
        return pickerOptions.count
    }
    
    func getPickerOption(row: Int) -> String {
        return pickerOptions[row]
    }
    
    func filteredTedTalks(searBarText: String, selectPicker: Int)  {
         tedTalks = manager.searchByFilter(searchText: searBarText, picker: selectPicker)
    }
}
