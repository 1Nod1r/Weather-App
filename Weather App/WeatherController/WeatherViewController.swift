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
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "image")
        return imageView
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.id)
        return tableView
    }()

    func setupBinding(){
        viewModel?.didChange = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 300)
        headerView.addSubview(imageView)
        imageView.frame = headerView.bounds
    }
    
    func configure(){
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
