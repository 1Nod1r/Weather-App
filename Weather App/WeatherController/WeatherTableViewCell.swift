//
//  WeatherTableViewCell.swift
//  Weather App
//
//  Created by Nodirbek on 17/05/22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    static let id = "WeatherTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    private func setup(){
        self.addSubview(temperatureLabel)
        self.addSubview(nameLabel)
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            nameLabel.topAnchor.constraint(equalTo: topAnchor,constant: padding),
            
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 85)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    func configure(with model: WeatherData, list: List){
        nameLabel.text = dateFormatter(date: list.dt)
        temperatureLabel.text = "\(list.temp.average) ℃"
    }
    
    private func dateFormatter(date: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(date))
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = .current
        let now = df.string(from: date as Date)
        return now
    }
}
