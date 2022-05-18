//
//  HeaderView.swift
//  Weather App
//
//  Created by Nodirbek on 18/05/22.
//

import UIKit

class HeaderView: UIView {
    
    private let weatherImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
}

