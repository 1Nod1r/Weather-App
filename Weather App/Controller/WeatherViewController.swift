//
//  ViewController.swift
//  Weather App
//
//  Created by Nodirbek on 17/05/22.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    var viewModel: WeatherViewModel?
    let headerView = HeaderView(frame: .zero)
    
    private let searchController: UISearchController = {
        let search = UISearchController()
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type a city name..."
        return search
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = UIColor(red: 168/255, green: 230/255, blue: 238/255, alpha: 1)
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.id)
        return tableView
    }()

    func setupBinding(){
        viewModel?.didChange = {
            DispatchQueue.main.async {[weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width)
    }
    
    private func configureHeaderView(){
        guard let name = viewModel?.weather?.name,
              let temperature = viewModel?.weather?.list[0].temp.average else {
            return
        }
        headerView.configure(viewModel: HeaderViewModel(cityName: name, temperature: "\(temperature)℃"))
    }
    
    private func configure(){
        viewModel = WeatherViewModel()
        setupBinding()
        viewModel?.getWeather()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
    }

}


extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.id, for: indexPath) as! WeatherTableViewCell
        guard let weather = viewModel?.weather, let list = viewModel?.item(for: indexPath.row) else { return UITableViewCell() }
        cell.configure(with: weather, list: list)
        configureHeaderView()
        cell.backgroundColor = UIColor(red: 168/255, green: 230/255, blue: 238/255, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension WeatherViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchBar.text != nil else {
            return
        }
        viewModel?.query = searchBar.text
        viewModel?.getWeather()
        searchBar.text = ""
    }
}
