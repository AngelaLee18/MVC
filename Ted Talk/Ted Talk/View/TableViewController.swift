//
//  ViewController.swift
//  Ted Talk
//
//  Created by Gonzalo Perretti on 4/6/21.
//

import UIKit

class TableViewController: UIViewController {
    
    // MARK: - IBOutles
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pickerView: UIPickerView!
    
    //MARK: - Properties
    lazy var viewModel = ViewModelTedTalk()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        bind()
        viewModel.fetchData()
    }
    
    func configurateView() {
        activityIndicator.hidesWhenStopped = true
        tableView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func bind() {
        viewModel.loadTableView = {
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.tableView.isHidden = false
            }
        }
        viewModel.refreshTableView = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableView Methods
extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tedTalksCell", for: indexPath) as?  PlayListCell else {
            return UITableViewCell()
        }
        let talk = viewModel.getTedTalk(indexPath: indexPath.row)
        cell.ShowPlaylistInformation(talk)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedPath = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "showDetail", let destination = segue.destination as? DetailViewController {
            destination.talk = viewModel.getTedTalkDetails(selectedPath: selectedPath.row)
        }
    }
}

// MARK: - UISearchBar and UIPickerView Methods
extension TableViewController: UISearchBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.getPickerOptionCount()
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
        viewModel.searchByFilter(searchText: searchBar.text ?? "", picker: pickerView.selectedRow(inComponent: 0))
        
    }
}
