//
//  TopStackView.swift
//  Tinder-Clone
//
//  Created by Emir Alkal on 20.12.2022.
//

import UIKit

class TopStackView: UIStackView {

    // MARK: - Properties
    
    let buttons = [#imageLiteral(resourceName: "03_6"), #imageLiteral(resourceName: "03_7"), #imageLiteral(resourceName: "03_8")].map { image in
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }
    
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
        buttons.forEach { button in
            addArrangedSubview(button)
        }
        distribution = .fillEqually
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 70).isActive = true
    }

}
