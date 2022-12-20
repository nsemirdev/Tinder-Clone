//
//  MainStackView.swift
//  Tinder-Clone
//
//  Created by Emir Alkal on 20.12.2022.
//

import UIKit

class MainStackView: UIStackView {

    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure() {
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setSubviews(_ views: [UIView]) {
        views.forEach { v in
            addArrangedSubview(v)
        }
    }
}
