//
//  HeaderView.swift
//  Weather App
//
//  Created by Nodirbek on 18/05/22.
//

import UIKit

class HeaderView: UIView {

    var itemViews: [UIView] = []
    
    private let backGroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.image = UIImage(named: "images")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let DateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.textAlignment = .center
        label.text = "Today"
        label.textColor = .black
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    private func setupUI(){
        let padding: CGFloat = 10
        itemViews = [backGroundImage, cityNameLabel, temperatureLabel, DateLabel]
        for itemView in itemViews {
            addSubview(itemView)
        }
        NSLayoutConstraint.activate([
            backGroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backGroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backGroundImage.topAnchor.constraint(equalTo: topAnchor),
            backGroundImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            
            DateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            DateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            DateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            DateLabel.heightAnchor.constraint(equalToConstant: 27),
            
            cityNameLabel.topAnchor.constraint(equalTo: DateLabel.bottomAnchor, constant: padding),
            cityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            cityNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 27),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: padding),
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 27),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    public func configure(viewModel: HeaderViewModel){
        cityNameLabel.text = viewModel.cityName
        temperatureLabel.text = viewModel.temperature
    }
}

