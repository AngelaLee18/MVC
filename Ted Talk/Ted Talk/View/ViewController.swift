//
//  ViewController.swift
//  Ted Talk
//
//  Created by Gonzalo Perretti on 4/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutles
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pickerView: UIPickerView!
    
    //MARK: - Properties
    lazy var viewModel = ViewModelTedTalk()
    //var manager: DataManager = DataManager()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        bind()
    }
    
    func configurateView() {
        activityIndicator.hidesWhenStopped = true
        tableView.isHidden = true
        activityIndicator.startAnimating()
        viewModel.fetchData()
    }
    
    func bind() {
        viewModel.loadTableView = {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.isHidden = false
            }
        }
        viewModel.refreshTableView = {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableView Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRow() //Agregar getNumberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getTedTalk(indexPath: indexPath, tableView: tableView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        viewModel.getTedTalkDetails(tableView: tableView, segue: segue)
    }
}

// MARK: - UISearchBar and UIPickerView Methods
extension ViewController: UISearchBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.getCantOfPickerOption()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.getPickerOption(row: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard !(searchBar.text?.isEmpty ?? true) else { return }
        filter()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter()
    }
    
    func filter() {
        viewModel.filterTedTalks(searBarText: searchBar.text ?? "", selectPicker: pickerView.selectedRow(inComponent: 0))
        
    }
}
