//
//  DailyTableViewCell.swift
//  Weather App
//
//  Created by Nodirbek on 17/05/22.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    static let id = "DailyTableViewCell"
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(collectionView)
        collectionView.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }

}

extension DailyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
}
