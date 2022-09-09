//
//  ViewModelTedTalk.swift
//  Ted Talk
//
//  Created by Angela Lee on 08/09/2022.
//

import Foundation
import UIKit

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
    
    
    // MARK: - Fetching funtions
    
    func fetchData() {
        manager.getDataTedTalks() { tedTalks in
            self.loadTableView?()
            self.tedTalks = tedTalks
        }
    }
    
    func getNumberOfRow() -> Int {
        return tedTalks.count
    }
    
    func getTedTalk(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tedTalksCell", for: indexPath) as?  PlayListCell else {
            return UITableViewCell()
        }
        cell.ShowPlaylistInformation(.init(talk: tedTalks[indexPath.row]))
        return cell
    }
    
    func getTedTalkDetails(tableView: UITableView, segue: UIStoryboardSegue ) {
        guard let selectedPath = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "showDetail", let destination = segue.destination as? DetailViewController {
            destination.talk = .init(talk: tedTalks[selectedPath.row])
        }
    }
    
    func getCantOfPickerOption() -> Int {
        return pickerOptions.count
    }
    
    func getPickerOption(row: Int) -> String {
        return pickerOptions[row]
    }
    
    func filterTedTalks(searBarText: String, selectPicker: Int)  {
         tedTalks = manager.searchByFilter(searchText: searBarText, picker: selectPicker)
    }
}
