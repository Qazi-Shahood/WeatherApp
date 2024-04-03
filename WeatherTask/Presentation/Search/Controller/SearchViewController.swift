//
//  SearchViewController.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import UIKit

class SearchViewController: UIViewController {

    private let searchController = UISearchController(searchResultsController: nil)
    let viewModel: SearchViewModel
    private let navigator: SearchCordinatorNavigator?
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Inits
    init(navigator: SearchCordinatorNavigator, viewModel: SearchViewModel) {
        self.navigator = navigator
        self.viewModel = viewModel
        super.init(nibName: "SearchViewController", bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Search"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        self.title = ""
    }
    
    func setupSearch() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Enter city name here"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func registerCells() {
        tableView.register(SearchTableViewCell.self)
    }

}

extension SearchViewController: SearchViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
    
    func showError(errorString: String) {
        showAlert(message: errorString)
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.cityList[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = viewModel.cityList[indexPath.row]
        navigator?.locationSelected(with: "\(city.lat)", long: "\(city.lon)")
    }
    
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text,
                !text.isEmpty else { return }
        viewModel.isSearchActive = searchController.isActive
        viewModel.getCityNames(for: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.isSearchActive = false
        viewModel.clearData()
    }
    
}
