//
//  ViewController.swift
//  Ted Talk
//
//  Created by Gonzalo Perretti on 4/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pickerView: UIPickerView!

    var tableViewData: [TedTalkData] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var manager: DataManager = DataManager()
    let pickerOptions = ["All", "Event", "Main speaker", "Title", "Name", "Description"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        manager.getDataTedTalks { tedTalksData in
            self.tableViewData = tedTalksData
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tedTalksCell", for: indexPath) as?  PlayListCell else {
            return UITableViewCell()
        }
        cell.ShowPlaylistInformation(.init(talk: tableViewData[indexPath.row]))
        return cell
    }
}

extension ViewController: UISearchBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard !(searchBar.text?.isEmpty ?? true) else {
            return
        }
        tableViewData = callSearchenteredWord()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableViewData = callSearchenteredWord()
    }
    
    func callSearchenteredWord() -> [TedTalkData] {
        var result: [TedTalkData]
        result = manager.searchEnteredWord(searchText: searchBar.text ?? "", picker: pickerOptions[pickerView.selectedRow(inComponent: 0)])
        return result
    }

}
